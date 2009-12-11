##This override script will invoke the SRMStsadmServices 
# to deploy the WSS wsp solution file 

param($deployer)

$deployer.logger.log("in OverridePush for WSP", "debug")

$deployer.logger.log("Getting started", "debug")

[string] $wspDir = $(Join-Path $deployer.buildData.Droplocation "WSP")

if ($deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='WSP']"))
{
	[string] $results = ""
	
	if ($deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='WSP']").DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").Options.SelectSingleNode("Option[@Key='SiteUrl']"))
	{
		[string] $siteUrl = $deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='WSP']").DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").Options.SelectSingleNode("Option[@Key='SiteUrl']").Value
		
		foreach ($location in $deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='WSP']").DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").RegionLocations.Location)
		{
			$regionEndpoint = $location.Path 
			
			foreach ($package in  $(ls $(Join-path $wspDir "*") -include *.wsp))
			{
				$deployer.logger.log("Calling AddSolutionWSP", "debug")
				$results += .\TFSDeployerScripts\CommonOverrides\LGBP\WSP\Invoke-AddSolutionWsp.ps1 "$package" $siteUrl "$regionEndPoint"
			}
			
			if ($results -match "error")
			{
				$deployer.logger.log($results, "error")
				return $false
			}
			else
			{
				#all went well than we need to run an iisreset have moss 
				#pick up the changes added with the solution (wsp) 
				#since we have to siteUrl which has the host server name in
				#just need to regex it out
				
				[regex] $regex = [regex] "http://(\w+?):"
				[string] $iis = $($($regex.match($siteUrl)).groups[1].value)
				
				$results += "<Result cmd=`"IISREEST /noforce $iis`">"
				$results += iisreset -noforce $iis 2>&1
				$results += "</Result>"
			}
		}
	}
	else
	{
		$deployer.logger.log("No WSP package site Url found in Options in deploymentconfig.xml. Option Key=`"SiteUrl`" is required", "error")

		return $false	
	}
	
	$deployer.DeploymentNote.Note = $results
	
	return $true
}

$deployer.logger.log("No WSP package found", "error")

return $false	