param( $deployer = $(throw 'SRM TFS Deployer object is required'))

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 

###MAIN###


Push-Location $(split-path $(get-script))

if ($($deployer.RegionName.Name).Equals("Dev"))
{ 
	$deployer.logger.log("No update of Environment Mapping deployment to DEV", "config")
	return $true
}

$infoLogAppendment = $("`nENV => " + $($deployer.RegionName.Name) + "`nKey => " + $deployer.BuildData.BuildType + "`nBuildNumber => " + $deployer.BuildData.BuildNumber ) 
$deployer.logger.log($("Starting update of Environment Mapping" + $infoLogAppendment), "config")

[datetime] $date = Get-Date

[string] $rbb = .\Get-RollbackBuildNumber.ps1 $deployer.BuildData.BuildType $($deployer.RegionName.Name) $deployer.BuildData.BuildNumber  $deployer.config.deployment.ConnectionString

.\Update-EnvMapDB.ps1 $deployer $rbb $date

$deployer.logger.log("Environment Mapping update complete", "debug")
Pop-Location
return $true
