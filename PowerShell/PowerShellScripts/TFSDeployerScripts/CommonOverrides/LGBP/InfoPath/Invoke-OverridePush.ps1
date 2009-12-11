##This override script will invoke the SRMStsadmServices 
# to deploy the WSS XSN solution file 

param($deployer)

$deployer.logger.log("in Common OverridePush for InfoPath", "debug")

[string] $xsnDir = $(Join-Path $deployer.buildData.Droplocation "XSN")

if ($deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='XSN']"))
{
	[string] $results = ""
	[string] $siteUrl = ""
	
	#check to ensure proper config enteries are there
	
	if ($deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='XSN']").DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").SelectSingleNode("Options[@Name='Moss']").SelectSingleNode("Option[@Key='SiteUrl']"))
	{
		$siteUrl = $deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='XSN']").DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").SelectSingleNode("Options[@Name='Moss']").SelectSingleNode("Option[@Key='SiteUrl']").Value
	
		foreach ($location in $deployer.DeploymentConfig.Settings.Packages.SelectSingleNode("Package[@PackageName='XSN']").DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").RegionLocations.Location)
		{
			$regionEndpoint = $location.Path 
			
			#here I am locking the deploy so only one can be run at a time 
			#for some reason a second deployment in the STG keeps running 20 -30 minutes after the first one
			#I've checked the deploymentmapping.xml a number of times to see if there we any double entries 
			# 
			
			[string] $lockFile = "XSN_" + $($deployer.RegionName.Name) + ".lck"
			[string] $fullPath2LockFile = Join-Path $deployer.Config.Deployment.TempLocation $lockfile
			
			if (!(Test-Path $fullPath2lockFile))
			{
				new-item -path $deployer.Config.Deployment.TempLocation -itemtype file -name $lockFile | out-null
			}
			else
			{
				$deployer.logger.log("An InfoPath deployment to this region is already on the way", "error")
				return $false
			}
			
			foreach ($package in  $(ls $(Join-path $xsnDir "*") -include *.XSN))
			{
				$result = ""
				$deployer.logger.log("Calling InfoPath web service $regionEndPoint $package", "debug")
				
				$sha1File = $package.FullName -replace "\.xsn", ".sha1"
				[string] $sha1 = ""
				
				if (Test-Path $sha1File)
				{
					$sha1 = $(gc $sha1File)
					
					$sha1 = $sha1.trim()
					
					$deployer.logger.log("SHA1 => $sha1", "debug")
				}
				
				$result = .\TFSDeployerScripts\CommonOverrides\LGBP\InfoPath\Invoke-DeployInfoPath.ps1 "$package" "$regionEndPoint" $siteUrl $sha1
				$results += $result
				
				$deployer.logger.log("Results: $result", "debug")
				
				$deployer.Mailer.Subject = "InfoPath deployment Update: $siteUrl"
				$deployer.Mailer.Body = "<h1>Results</h1><br><b>SiteUrl:</b> $siteUrl<br><b>SXN:</b> $package<br><hr>$result"
				$deployer.Mailer.Send() | out-null
			}
			
			#unlock 
			remove-item -path $fullPath2LockFile -force | out-null
			
			if ($results -match "ERROR")
			{
				$deployer.logger.log($results, "error")
				return $false
			}
		}
	}
	else
	{
		$deployer.logger.log("No XSN Site Url found in Options key SiteUrl", "error")
		return $false
	}
	
	$deployer.DeploymentNote.Note = $results
	
	#$deployer.Message.AppendLine($results)
	
	return $true
}

$deployer.logger.log("No XSN package(s) found", "error")

return $false

	
		