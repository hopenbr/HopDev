#Common Overide for LGBP UDCX deployments

##This override script will invoke the SRMStsadmServices 
# to deploy the WSS UDCX file upload

param($deployer)

$deployer.logger.log("in OverridePush for Common LGBP UDCX", "debug")

$deployer.logger.log("Getting started", "debug")

[bool] $noPackage = $true

[string] $results = ""

if ($deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='UDCX']"))
{
	$noPackage=$false
	
	[string] $dataConnUrls = $deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='UDCX']").DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").SelectSingleNode("Options[@Name='Udcx']").SelectSingleNode("Option[@Key='DataConnectionLibraryUrl']").Value
	[string] $webServiceUrl = $deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='UDCX']").DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").SelectSingleNode("Options[@Name='Udcx']").SelectSingleNode("Option[@Key='WebServiceUrl']").Value
	
	foreach ($location in $deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='UDCX']").DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").RegionLocations.Location)
	{
		[string] $regionEndpoint = $location.Path 
		
		foreach ($dataConnUrl in $($dataConnUrls.Split(",")))
		{
			$deployer.logger.log("Calling UDCX web service $regionEndPoint", "debug")
			$results += .\TFSDeployerScripts\CommonOverrides\LGBP\UDCX\Invoke-DeployUdcx.ps1 $(Join-Path $deployer.BuildData.DropLocation "UDCX") $dataConnUrl "" $webServiceUrl "$regionEndPoint"
			$deployer.logger.log("Results: $results", "debug")
		}
		
		
		if ($results -match "ERROR")
		{
			$deployer.logger.log($results, "error")
			$deployer.Message.AppendLine($results)
			return $false
		}
	}
	
}

if($noPackage)
{
	$deployer.logger.log("No UDCX package(s) found", "error")
	return $false
}

	
$deployer.DeploymentNote.Note = $results

return $true
		
		