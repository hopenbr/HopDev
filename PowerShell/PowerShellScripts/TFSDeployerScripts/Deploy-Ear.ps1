#EarDeployer 
#This script to deployer ear files to proper environment
#
param($deployer = $(throw 'Error: SRM TFS deployer object is required'),
	  [string] $appName = $(throw 'The App name that being migrated is required'))


function get-script
{
   	if($myInvocation.ScriptName) 
   	{
   		$myInvocation.ScriptName 
	}
   	else
   	{ 
   		$myInvocation.MyCommand.Definition 
	}
	
}

function get-path2Ear ([string] $dl, [string] $ap)
{
	$earFolder =  Get-Item $(Join-Path $dl $ap)
	
	if ($earFolder.Exists)
	{
		$files = $earFolder.GetFiles("*.EAR")
		
		if ($files.count -eq 1)
		{
			return $files[0].FullName
		}
		else
		{
			throw "Error: Cannot determine unquie EAR file in build package"
		}
	}
	else
	{
		throw "Error: Team Build package does not contain EAR folder"
	}
}

###MAIN###

Push-Location (Split-Path $(get-script))

[string] $_SDLC = ""
##Looking for SDLC in DeploymentConfig.xml 
if ($deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='$appName']").DeploymentRegions -and 
	$deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='$appName']").DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").WasSDLC)
{
	$_SDLC = $deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='$appName']").DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").WasSDLC
}
elseif ($deployer.Config.Deployment.WAS.SDLCs.SelectSingleNode("SDLC[@DefaultRegion='$($deployer.RegionName.Name)']"))
{#DeploymentConfig.xml did not have a WasSDLC attribute now need to look for the Default for the Region in the Config.xml
	$_SDLC = $deployer.Config.Deployment.WAS.SDLCs.SelectSingleNode("SDLC[@DefaultRegion='$($deployer.RegionName.Name)']").Name
}
else
{
	throw "Error: No WAS SDLC Region was found for $($deployer.RegionName.Name)"
}
 
$xSDLC = $deployer.Config.Deployment.WAS.SDLCs.SelectSingleNode("SDLC[@Name='$_SDLC']")

$_path2Ear = get-Path2Ear $deployer.BuildData.DropLocation $appName

$deployer.logger.log("WAS Deployment of $appName to $_SDLC`nHost = $($xSDLC.Host)`nPost = $($xSDLC.Port)`nUser = $($xSDLC.User)`nPwd = $($xSDLC.Pwd)", "info")

$returnCode = .\WAS_TFSBuild.ps1 $_SDLC $xSDLC.Host $xSDLC.Port $xSDLC.User $xSDLC.Pwd $appName $_path2Ear

$deployer.Message.AppendLine("Ear file deployed: $(split-path $_path2Ear -leaf)")

Pop-Location

return $true