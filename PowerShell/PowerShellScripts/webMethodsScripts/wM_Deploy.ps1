
param( [string] $sdlc = $(throw 'Exception: missing argument specifying SDLC'),
	   [string] $package_name = $(throw 'Exception: missing argument Specifying package'),
	   $deployer = $(throw 'SRM TFS deployer object is required'),
	   [string] $file_name = $($package_name + ".zip"))


function MyDoWeb ([String]$url, [string]$wM_Admin_auth ) {
	$req=[system.Net.HttpWebRequest]::Create($url);
	$req.UserAgent = "PowerShell Script"
	$req.Headers.Add("Authorization", $wM_Admin_auth )
	$req.Timeout = 840000 	# which is 420 seconds, or 7 minutes
	$res = $req.getresponse();
	$stat = $res.statuscode;
	$requestStream = $res.GetResponseStream()
	$readStream = new-object System.IO.StreamReader $requestStream
	$output = $readStream.ReadToEnd()
	$readStream.Close()
	$res.Close();
	return $output
}



function package_disable ([string]$uri, [string]$wM_Admin_auth, [string]$packageName, [string]$sdlc) {
	$output = ""
	$url = "$uri/WmRoot/package-list.dsp?action=disable&package=$packageName"
	$output = MyDoWeb $url $wM_Admin_auth
	if ($output -like "*package disabled.*") {
		Log "$sdlc $packageName disabled." "debug"
	} else {
		Log "$sdlc $packageName WARNING: MAY BE NEW TO THE ENVIRONMENT.  VERIFY CNF, ACL, etc." "warning"
	}
}



function package_install ([string]$uri, [string] $wM_Admin_auth, [string]$fileName, [string]$sdlc) {
	$output = ""
	$url = "$uri/WmRoot/package-inbound.dsp?action=install&file=$fileName"
	$output = MyDoWeb $url $wM_Admin_auth
	if ($output -like "*package installed*") {
		Log "$sdlc $fileName" "debug"
	} else {
		Log "$sdlc FAILED TO INSTALL $fileName" "error"
		
		$deployer.Mailer.Subject = "$sdlc FAILED TO INSTALL $fileName"
		$deployer.Mailer.Body = $output
		
		throw "FAILED TO INSTALL $fileName.  HTML Output displayed`n" + ($deployer.Mailer.Send())
	}
}



function change_CNF ([string]$sdlc, [string]$package, [string]$_server) 
{
	$searchXml = [xml] (Get-Content .\webMethodsScripts\wMEnvSearchAndReplaceMappings.xml)
	$cnfPath = ("\\" + $_server + "\packages\" + $package + "\config\")
	
	
	log ("Updating cnf`nPackage: " + $package + "`nPath: " + $cnfPath) "debug"
	
	if ($searchXml.Packages.SelectSingleNode("Package[@Name='$package']"))
	{
		if ($searchXml.Packages.SelectSingleNode("Package[@Name='$package']").Environments.SelectSingleNode("Environment[@Name='$sdlc']"))
		{
			[string] $log = ""
			$cnfPath += ($searchXml.Packages.SelectSingleNode("Package[@Name='$package']").Environments.SelectSingleNode("Environment[@Name='$sdlc']").Searches.GetAttribute("FileName2Search"))
			$cnf = (get-content $cnfPath)
			
			foreach ($search in $searchXml.Packages.SelectSingleNode("Package[@Name='$package']").Environments.SelectSingleNode("Environment[@Name='$sdlc']").Searches.Search)
			{
				$regex = [regex] $search.GetAttribute("Regex")
				$replace = $search.GetAttribute("Replace")
				
				if ($regex.IsMatch($cnf))
				{
					$cnf = $cnf -replace $regex, $replace
					
					$log += ("`nSearched (" + ($regex.ToString()) + ") Replaced with (" + $replace + ")`n")
				}
				else
				{
					throw ("Wm Deployer Error: CNF update package " + $package + " empty search results. `nSearch: " + ($regex.ToString()) + "`nCNF: " + $cnfPath)
						
				}
			}
			
			set-content -path $cnfPath -value $cnf
			
			log ("Update Complete:`nPackage: " + $package + "`nPath: " + $cnfPath + "`n" + $log) "debug"
		}
		else
		{
			throw ("Wm Deployer Error: CNF update package " + $package + " No environment (" + $sdlc + ") Searches found" )
		}
		
	}
	else
	{
		$warn =  ("WmDeployer: "  + $package + " No Searches to update" )
		
		$deployer.logger.log($warn, "warning", "4201")
	}

}

function replace_CNF ([string]$sdlc, [string]$package, [string]$_server) 
{
	log ("Start overlay of CNF") "debug"
	
	$cnfPath = ("\\" + $_server + "\packages\" + $package + "\config\")
	log ("Path set") "debug"
	$cnfEnvConfigPath = $($TFSDeployerBuildData.DropLocation + "\Env.Config\" + $sdlc + "\" + $package)
	
	if (!(Test-Path $cnfEnvConfigPath))
	{
		if ($sdlc.Equals("QA2"))
		{
			$cnfEnvConfigPath = $($TFSDeployerBuildData.DropLocation + "\Env.Config\TST2\" + $package)
		}
		
		if (!(Test-Path $cnfEnvConfigPath) -and !$wMNoConfigs)
		{
			throw $("Error: Could not resolve config location " + $cnfEnvConfigPath)
		}
	}
	
	log ("CNF Folder: " + $cnfPath + "`nEnvConfig Folder: " + $cnfEnvConfigPath) "debug"
	
	if (Test-Path (Split-path $cnfEnvConfigPath -parent))
	{
		if (Test-Path $cnfEnvConfigPath)
		{
			foreach ($cnf in get-childitem $cnfEnvConfigPath)
			{
				log ("Replacing " + (join-path $cnfPath $cnf.Name) + "`nWith " + $cnf.FullName) "debug"
				set-content -path (join-path $cnfPath $cnf.Name) -value (get-content $cnf.FullName)
				log ("Replacement Complete")
			}
		}
		else
		{
			$warn =  ("No env.config cnf found for " + $package + " in " + $sdlc)
		
			$deployer.logger.log($warn, "warning", "4201")
		}
			
	}
	else
	{
		log ("Old package going to XML update of CNF")
		change_CNF $sdlc $package $_server
	}
	
}

function package_activate ([string]$uri, [string] $wM_Admin_auth, [string]$packageName, [string]$sdlc) {
	$output = ""
	$url = "$uri/WmRoot/package-manage.dsp?action=activate&package=$packageName"
	$output = MyDoWeb $url $wM_Admin_auth
	if ($output -like "*package activated.*") {
		Log "$sdlc $packageName activated." "config"
	} else {
		Log "$sdlc $packageName EXCEPTION: Failed in package_activate" "error"
		
		$deployer.Mailer.Subject = "TFSDeployer wM Error"
		$deployer.Mailer.body = $output
		
		throw "Failed in package_activate`n" + $($deployer.Mailer.Send())

	}
}



function package_reload ([string]$uri, [string] $wM_Admin_auth, [string]$packageName, [string]$sdlc) {
	$output = ""
	$url = "$uri/WmRoot/package-list.dsp?action=reload&package=$packageName"
	$output = MyDoWeb $url $wM_Admin_auth
	if ($output -like "*package reloaded.*") {
		Log "$sdlc $packageName reloaded."
	} else {
		Log "$sdlc Failed in package_reload for $fileName"
		Send_Email "dmiller@harleysvillegroup.com" "wM Deploy Failed in package_reload for $fileName in $sdlc" "$output"
		throw "(IF NO HTML OUPUT FOLLOWS SEE SERVER LOG ENTRIES AT $wM_Admin_host).  HTML Output"
	}
}



function run_Service ([string]$uri, [string] $wM_Admin_auth, [string]$packageName, [string]$sdlc) {
	$output = ""
	$url = "$uri/invoke/$packageName"
	$output = MyDoWeb $url $wM_Admin_auth
	Log "$sdlc Service $packageName executed." "config"
}



##function check-sdlc ([string]$sdlc) {
##	# If not one of the expected life cycle stages of the SDLC, throw exception
##	$a = "SBX", "ASY", "TST1", "TST2", "E2E", "TRN", "PRE", "PRD1", "PRD2"
##	if ($a -contains $sdlc) {
#		switch ($sdlc) {
#        		"SBX"  {$wM_Admin_auth = "Basic QWRtaW5pc3RyYXRvcjpTQjB4JkFkbTFu"	# SANDBOX2
#			$wM_Admin_host = "http://as73esbsandbox2:5555"
#			}
#        		"ASY"  {$wM_Admin_auth = "Basic QWRtaW5pc3RyYXRvcjpBc3kwMSZBZG0xbg=="
#				$wM_Admin_host = "http://as73esbasy01:5555"
#			}
#       		"TST1" {$wM_Admin_auth = "Basic QWRtaW5pc3RyYXRvcjptYW5hZ2VpY2M="	# TST1
#				$wM_Admin_host = "http://as73esbtst01:5555"
#			}
#        		"TST2" {$wM_Admin_auth = "Basic QWRtaW5pc3RyYXRvcjpUc3QwMiZBZG0xbg=="
#				$wM_Admin_host = "http://as73esbtst02:5555"
#			}
#       		"E2E"  {$wM_Admin_auth = "Basic QWRtaW5pc3RyYXRvcjpFc2UwMSZBZG0xbg=="
#				$wM_Admin_host = "http://as73esbe2e01:5555"
#			}
#			"TRN"  {$wM_Admin_auth = "Basic QWRtaW5pc3RyYXRvcjpUcm4wMSZBZG0xbg=="
#				$wM_Admin_host = "http://as73esbtrn01:5555"
#			}
#        		"PRE"  {$wM_Admin_auth = "Basic QWRtaW5pc3RyYXRvcjpQcmUwMSZBZG0xbg=="
#				$wM_Admin_host = "http://as73esbpre01:5555"
#			}
#        		"PRD1" {$wM_Admin_auth = "Basic QWRtaW5pc3RyYXRvcjpQcmQmQWRtMW4="	# PROD
#				$wM_Admin_host = "http://as73esbprd01:5555"
#			}
#			"PRD2" {$wM_Admin_auth = "Basic QWRtaW5pc3RyYXRvcjpQcmQmQWRtMW4="	# PROD
#				$wM_Admin_host = "http://as73esbprd02:5555"
#			}
#        		default {
#				Log "Invalid argument $sdlc, is not a valid life cycle stage of the SDLC"
#				Send_Email "dmiller@harleysvillegroup.com" "wM Deploy Failed in check-sdlc" "Invalid argument $sdlc, is not a valid life cycle stage of the SDLC"
#				Throw "Invalid argument $sdlc, is not a valid life cycle stage of the SDLC"
#			}
#		}
#		return $wM_Admin_host, $wm_Admin_auth
##	} Else {
##		Throw "Invalid argument $sdlc, is not a valid life cycle stages of the SDLC: $a"
##	}
#}



function Send_Email (
	[string] $recipient = $(throw 'recipient address is required'),
	[string] $subject = $(throw 'message subject is required'),
	[string] $body = $(throw 'message body is required')
) {
	$deployer.Mailer.Subject = $subject
	$deployer.Mailer.Body = $body
	$deployer.Mailer.recipient += "; " + $recipient 
	
	$deployer.Mailer.Send() | out-null
}



##############################
# Write output to a LOG file
##############################
function Log ( [string] $s, [string] $level ) 
{
	#ensure log level is pass in correctly if not default it to debug
	switch ($level)
	{
		"debug" {}
		"config" {}
		"waring" {}
		"info" {}
		"error" {}
		default {$level = "debug"}
	}
	
	$deployer.logger.log($s, $level)
}



function echo-args{
	for($i=0;$i -lt $args.length;$i++){
		"Arg $i is <" +$args[$i]+">";
	}
}

function clear-Cache ([string] $_url, [string] $_wM_Admin_auth, [string] $_sdlc)
{
	run_Service $_url $_wM_Admin_auth "hmiCommon.config/clearCache" $_sdlc
}



############################
#
# Main section starts here
#
############################
#
# Main Section starts here
#
############################

" "
Log "*** wM Deployment Script Start." "debug"

$sdlc = $sdlc.ToUpper()
	
foreach ($server in $deployer.Config.Deployment.Environments.SelectSingleNode("Environment[@ShortName='$sdlc']").wM.Servers.Server)
{
	if ($server -contains $null)
	{
		throw "Exception: Incorrect SDLC/Environment given ($sdlc)"
	}
	
	log $("Deploying to Server: " + $server.GetAttribute("Name")) "config"
	
	$url = $("http://" + $server.GetAttribute("Name") + ":5555")
	$wM_Admin_auth = $server.wM_Admin_auth

	# if package is not to be in source control, throw an exception
	$na = "HmiResources", "PSUtilities", "logging"
	if ($na -contains $package_name) {
		Log "!!! $package_name, is not to deployed by this process.  See the webMethods SysAdmin" "error"
		Throw "This package, $package_name, is not to deployed by this process.  See the webMethods SysAdmin"
	}

	# if the name of a service is entered for package name, then run service
	# presently we allow onluy the following services to be executed this way:
	$sn = "hmiCommon.config/clearCache", "hmiAQSTokenManager.services/invalidateAQSToken"
	if ($sn -contains $package_name) {
		run_Service $url  $wM_Admin_auth $package_name $sdlc
	} 
	else 
	{

		if ($deployer.DeploymentType -eq "full")
		{
		#	package_disable  $url  $wM_Admin_auth $package_name $sdlc
			package_install  $url  $wM_Admin_auth $file_name    $sdlc
			replace_CNF $sdlc $package_name $server.GetAttribute("Name")
			package_activate $url  $wM_Admin_auth $package_name $sdlc
			package_reload   $url  $wM_Admin_auth $package_name $sdlc
		}
		else
		{
			replace_CNF $sdlc $package_name $server.GetAttribute("Name")
		}

	}
}
Log "*** Deployment Script Completed." "debug"
" "
