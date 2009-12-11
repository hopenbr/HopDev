###############
#Deploy-Documaker
#This script wil be used to promote Documaker element from one region
#to the next
#This script will be called from the Invoke-AfterPush addin Scripts for 
#each Documaker project 
#
#################

param($deployer = $(throw 'The SRM TFS Deployer object is required'),
	  $path2DocuConfig = $(throw 'The full path to the Documaker Config xml is Required'))

function create-RandomString ([int] $length)
{
	$rand = New-Object System.Random
	[string] $rstr = ""
	1..$length | ForEach { $rstr = $rstr + [char]$rand.next(65,90) }
	return $rstr
	
}


function get-cmd ([string] $_path2Lsc, 
				  [string] $_path2Ini, 
				  [string] $_path2shipW32,
				  [bool] $_isTest)
{
	##This function will create the batach file a promote of one LSC 
	#it will return a fileInfo object of the batch file
	$deployer.logger.log("In get-cmd", "debug")
	
	[System.IO.DirectoryInfo] $shipw32 = Get-Item $_path2shipW32
	
	[System.IO.FileInfo] $bat = New-Item -ItemType file -Path (Join-Path $shipw32.Parent.FullName "Bat") -Name $((create-RandomString 12) + ".bat")
	
	$deployer.logger.log("BAT: $bat.FullName", "debug")
	
	[string] $test = ""
	
	if ($_isTest)
	{
		$test = "/test"
	}

	[string] $driveLetter = $shipw32.Root.Name -replace "\\", ""
	
	" $($driveLetter) 2>&1
cd $($shipw32.FullName) 2>&1
LBYPROC /i=`"$_path2Lsc`" /ini=`"$_path2Ini`" $test 2>&1
	" | Out-File -FilePath $bat.FullName -Encoding ASCII
	
	$deployer.logger.log("Returning Bat", "debug")
	
	return $bat
}



###MAIN###

$deployer.logger.log("In Deploy-Documaker", "config")

$dconfig = [xml] $(gc $path2DocuConfig) 

[string] $path2lsc = $deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='LSC']").DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").RegionLocations.Location.GetAttribute("Path")

[bool] $successful = $true

[string] $path2Ini = (Join-path ($deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='INI']").DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").RegionLocations.Location.GetAttribute("Path")) $dconfig.Settings.IniFileName)

[int] $runCount = 0

foreach ($lsc in (gci  (Join-Path $path2lsc "*") -include "*.lsc"))
{
	$deployer.logger.log("LSC => $lsc", "debug")
	
	$runCount++ 
	
	[System.IO.FileInfo] $bat = get-cmd $lsc.FullName $path2Ini $dconfig.Settings.Path2ShipW32 $true
	
	[string] $output = cmd /c $bat
	
	$deployer.logger.log("Test out => $output", "debug")
	
	if ($output -match "PROMOTE Successful")
	{
		$bat.Delete()
		
		$bat = get-cmd $lsc.FullName $path2Ini $dconfig.Settings.Path2shipW32 $false
		
		$output = cmd /c $bat
		
		if ($output -match "PROMOTE Successful")
		{
			$bat.Delete()
			continue
		}
	}
	
	#will never get to this section unless Promote... is not found in the output 
	
	$successful = $false
	
	$deployer.Mailer.Subject = "TFSDeployer Error Documaker"
	$deployer.Mailer.Body = "There was an Error during the promote<br><br>CMD:<br><p>" +  
		$(gc $bat.fullName | Out-String) +
		"</p><br>Output:<br><p>$output</p>"
	$deployer.Mailer.Send() | Out-Null
	
	$bat.Delete()
	
	break
	
}

$deployer.logger.log(("Successful = $successful"), "debug")

if ($runCount -gt 0)
{
	return $successful
}
else
{
	#No runs were made meaning no lsc file in deployment area
	$deployer.Mailer.Subject = "TFSDeployer Error Documaker"
	$deployer.Mailer.Body = "There were no lsc files to promote in directory:`n" + $path2lsc 
	$deployer.Mailer.Send() | Out-Null
	return $false
}