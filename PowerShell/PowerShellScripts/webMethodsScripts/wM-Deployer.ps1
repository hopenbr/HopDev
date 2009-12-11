param($deployer = $(throw 'SRM TFS deployer object is required'))

trap 
{
	
	$msgLog = "Error trapped in $script`n`n$_"
	
	$deployer.logger.log($msgLog, "Error", $eventLogErrorNumber);
	
	if ($_packageWasPushed2Inbound)
	{
		$deployer.logger.log($("Error captured during migration of " + $_packageTarget + "`nAttemping to delete package from the inbound directory"), "info")
		
		foreach ($target in $_packageTarget.Split(","))
		{
			remove-item -path $target -force
		}
		
		$deployer.logger.log($($_packageTarget + " was successfully removed from inbound directory"), "info")
	}
	 
	break;
} 

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

function clear-Cache ([string] $sdlc)
{
	$deployer.logger.log($("Clearing the cache of " + $deployer.RegionName.ShortName), "config")
	.\webMethodsScripts\wM_Deploy.ps1 $sdlc "hmiCommon.config/clearCache" $deployer
	$deployer.logger.log($("Cache has been cleared"), "debug")
}

###MAIN###

[bool] $_packageWasPushed2Inbound = $false
[string] $_packageTarget

$deployer.logger.log($($wMDeployHash.keys | foreach-object { foreach ($key in $wMDeployHash.$_.keys) {$($_.ToString() + " => " + $key.ToString() + " =>" + $wMDeployHash.$_.$key) } }), "config")

clear-Cache $deployer.RegionName.ShortName

foreach ($package in $wMDeployHash.keys)		
{
	if ($deployer.DeploymentType -eq "full")
	{
		$deployer.logger.log($("Deploying: " + $package + "`nFrom => " + $wMDeployHash.$package.Source + "`nTo => " + $wMDeployHash.$package.Target), "debug")
		
		foreach ($target in $wMDeployHash.$package.Target.Split(","))
		{
			Copy-item $wMDeployHash.$package.Source -force -recurse -destination $target
			$_packageTarget += $($wMDeployHash.$package.Target + "\" + $package + ".zip,")
		}
		
		$_packageTarget = $_packageTarget.TrimEnd(",")
		
		$_packageWasPushed2Inbound = $true
		$deployer.logger.log($("Importing`npackage: " + $package + "`nEnv: " + $deployer.RegionName.ShortName), "debug")
		.\webMethodsScripts\wM_Deploy.ps1 $deployer.RegionName.ShortName $package $deployer
		$_packageWasPushed2Inbound = $false
		$deployer.logger.log("Import Complete", "debug")
	}
	else
	{
		$deployer.logger.log($("Importing config for`npackage: " + $package + "`nEnv: " + $deployer.RegionName.ShortName), "debug")
		.\webMethodsScripts\wM_Deploy.ps1 $deployer.RegionName.ShortName $package $deployer
		$deployer.logger.log("Import Complete", "debug")
	}
}

clear-Cache $deployer.RegionName.ShortName

$deployer.Message.AppendLine("webMethods Cache was cleared before and after deployment")





