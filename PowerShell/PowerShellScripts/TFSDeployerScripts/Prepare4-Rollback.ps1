param($deployer = $(throw 'SRM TFS Deployer object is required'))


function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 

function send-email ($bd)
{
	$bdDetails = $bd | get-member | where {$_.Membertype -eq "Property"} | foreach {write-output $($_.Name + " => " + $bd.$($_.Name) + "`n")}
	$deployer.Mailer.subject = $deployer.BuildData.BuildNumber + "being roll back to " + $bd.BuildNumber 
	
	$deployer.Mailer.body = "Rollback of " + $deployer.BuildData.BuildNumber + " Started.`n" 
	$deployer.Mailer.body += "Build data for Rollback build:`n"
	$deployer.Mailer.body += $bdDetails + "`n"
	$deployer.Mailer.body += "This will be the only email you recieve please check event veiwer of " + $deployer.config.Deployment.TFSBuild 
	$deployer.Mailer.body += " for deployment status.  Moreover, you could wait until the build Quality of " + $bd.BuildNumber 
	$deployer.Mailer.body += " has been updated to the In-" + $rollbackEnv + " status" 
	
	$deployer.Mailer.Send() | out-null

}

function get-Xml([string] $connStr, [string] $_env, [string] $teamBuildType)
{
	#open connection to Database
	$conn = New-Object System.Data.SqlClient.SqlConnection 
	$conn.connectionstring = $connStr
	$conn.Open() | out-null
	$sqlcmd = New-Object System.Data.SqlClient.SqlCommand
	$sqlcmd.Connection = $conn
	$sqlcmd.commandtext = "SELECT $_env FROM DEPLOYMENTS WHERE TeamBuildType = '$teamBuildType'"
	$reader = $sqlcmd.ExecuteReader()
	
	while ($reader.read())
	{
		[string] $_xml = $reader.GetValue(0)
	}
	
	$reader.Close()
	$reader.Dispose()
	$conn.Close()
	
	return $_xml -replace "<Environments.*?>", "<Environments>"
}


###MAIN###

[string] $rollbackEnv = $($deployer.OriginalBuildQuality.Split("-"))[1]

$deployer.logger.log($("Preparing for " + $rollbackEnv + " rollback of build:`n" + $deployer.BuildData.BuildNumber), "info")

#get XML from DB
[xml] $xml = get-Xml $deployer.Config.Deployment.ConnectionString $rollbackEnv $deployer.BuildData.BuildType 

$deployer.logger.log($("Environment Mapping xml retrieved"), "debug")

$envMapBuildNode = $xml.Environments.SelectSingleNode("Environment[@Name='$rollbackEnv']").Builds.SelectSingleNode("Build[@TeamBuildType='$($deployer.BuildData.BuildType)']")

$deployer.logger.log($("Xpath for roll back build performed"), "debug")

if ($envMapBuildNode)
{
	$rollbackBuild = $envMapBuildNode.GetAttribute("RollBackBuild")
	
	$currentBuild = $envMapBuildNode.GetAttribute("BuildNumber")
	
	if ($currentBuild.Equals($($deployer.BuildData.BuildNumber)))
	{
		if ($rollbackBuild)
		{
			$deployer.logger.log("Roll back data found", "config")
			
			$tfs = .\Get-Tfs.ps1 

			$BuildUri = $tfs.TBP.GetBuildUri($deployer.BuildData.TeamProject, $rollbackBuild)

			$BuildData = $tfs.TBP.GetBuildDetails($BuildUri)
			
			if ($BuildData.BuildNumber.Equals($($deployer.BuildData.BuildNumber)))
			{
				throw "Rollback Error: Rollback build same as current build"
			}
			
			$build = "/BuildUri=" + $BuildUri

			$deployer.logger.log($("Rolling back to : " + $($BuildData.BuildNumber)), "info")
			
			.\Update-BuildQuality.ps1 $build $("In-" + $rollbackEnv) $deployer.BuildData.TeamProject $deployer.BuildData.BuildType
			
			write-debug "Sleeping"
			#need to sleep to allow for TFS to catch up before we ask for a deployment
			start-sleep -seconds 3 
			
			$deployer.logger.log($($($buildData.BuildNumber) + " quality changed to In-" + $rollbackEnv + ", now changing it to deploy2-" + $rollbackEnv + " which will kick of rollback deployment"), "debug")

			.\Update-BuildQuality.ps1 $build $("Deploy2-" + $rollbackEnv) $deployer.BuildData.TeamProject $deployer.BuildData.BuildType

			$deployer.logger.log("Rollback in progress", "debug")

			send-email $BuildData
			
			.\Update-BuildQuality.ps1 $("/BuildUri=" + $($deployer.BuildData.BuildUri)) 'Rejected' $deployer.BuildData.TeamProject $deployer.BuildData.BuildType
			
			.\TFSDeployerScripts\Update-WorkItem.ps1 $deployer
		}
		else
		{
			throw "No Roll back information available, manual rollback needed"
		}
	}
	else
	{
		
		throw $("Build: " + $($deployer.BuildData.BuildNumber) + " is not the current build (" + $currentBuild + ") in " + $rollbackEnv)
		
	}
}
else
{
	throw "No Build information available, manual rollback needed"
}

