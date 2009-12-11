##Update-EnvConfig
#This TFS Deployer script will update the Env.Config folder in 
#build package on the Buildstore, the elements are updated with 
#the lastest elements from TFVC 
#FullDates are kicked off when an Update-Configs is asked for 
#while when a Configs2-Env is called only that Env/regions configs 
#will be updated 
###

param($deployer = $(throw 'SRM TFS Deployer object is required'))

function get-DeploymentRegion ([string] $e)
{
	$dr = new-object Object
	
	if ($e.Equals("In-IRB"))
	{
		$e = "In-Production"
	}
	
	$dr |Add-Member -MemberType NoteProperty -Name "FullName" -Value $($e -as [string])
	
	$dr |Add-Member -MemberType ScriptProperty -Name "Name" -Value {$this.FullName.split("-")[1]}
	
	$dr |Add-Member -MemberType ScriptProperty -Name "ShortName" -Value {$deployer.Config.Deployment.Environments.SelectSingleNode("Environment[@FullName='$($this.FullName)']").GetAttribute("ShortName")}
	
	return $dr
}

###MAIN###

$deployer.logger.log("In Update Env Config", "debug")

[void] [Reflection.Assembly]::LoadWithPartialName("Microsoft.TeamFoundation.VersionControl.Client")

[bool] $fullUpdate = $true

$deployRegion = get-DeploymentRegion($deployer.Env)

if ($deployer.BuildData.BuildQuality.StartsWith("Configs2"))
{
	$deployer.logger.log("Region Only config update", "debug")

	$fullUpdate = $false
}

[string] $log = "Updating Build package Env.Config for Region: "

if($fullUpdate)
{
	$log += "Full update All regions"
}
else
{
	$log += $deployRegion.Name
}

$deployer.logger.log($log, "Info")

$localPath = (Join-path $deployer.Config.Deployment.TempLocation  $deployer.BuildData.BuildNumber)

if (Test-Path $localPath)
{
	Remove-Item -force -recurse $localPath
}

$local = new-item -path $deployer.Config.Deployment.TempLocation -Name $deployer.BuildData.BuildNumber -type Directory 
[bool] $wasLocPathGet = $false
[bool] $iswM = $false

if ((Test-Path (Join-Path $deployer.BuildData.DropLocation $("Env.Config\" + $deployRegion.ShortName))) -or 
	$fullUpdate)
{
	if ($fullUpdate)
	{
		foreach($package in $deployer.DeploymentConfig.Settings.Packages.Package)
		{
			if ($package.DeploymentType -eq "webMethods")
			{
				$iswM = $true
				break
			}
		}
		
		if ($iswM)
		{
			write-debug "Updating WebMethods Configs"
			
			[string] $serverPath = $("$/" + $deployer.BuildData.TeamProject + "/WmSourceControl/Config/")
		
			if (!($deployer.tfs.VCS.ServerItemExists($serverPath, [Microsoft.TeamFoundation.VersionControl.Client.ItemType]::Folder)))
			{
				$serverPath = $("$/WmProjects/WmSourceControl/Config/")
			}
			
			$ws = .\Get-FromTFVC.ps1 $local.FullName $serverPath 
			$wasLocPathGet = $true
			
			foreach ($e in (Get-ChildItem ($deployer.BuildData.DropLocation + "\Env.Config")))
			{
				foreach ($p in (Get-ChildItem $e.FullName))
				{
					$localPackageConfig = $($local.FullName + "\" + $e.Name + "\Packages\" + $p.Name + "\Config")
					
					if (Test-Path (Split-Path $localPackageConfig -parent))
					{
						$destination = $($deployer.BuildData.DropLocation + "\Env.Config\" + $e.Name + "\" + $p.Name)
					
						foreach ($file in (get-childitem $localPackageConfig | where-Object {!$_.Mode.Contains("d")}))
						{
							remove-item $(Join-Path $destination $file.Name) -force
							copy-item -path $file.FullName -destination $destination
						}
					}
					else
					{
						$deployer.logger.log($("No env.config cnf found for " + $localPackageConfig ), "warning", "4201")
						
					}
				}
			}
		}
	}
	else
	{
		[string] $region = $deployRegion.ShortName
		
		$deployer.logger.log("wM region Only update: $region", "debug")
		
		$ws = .\Get-FromTFVC.ps1 $local.FullName $($serverPath + "/" + $region + "/")
		$wasLocPathGet = $true
		
		foreach ($p in (Get-ChildItem ($deployer.BuildData.DropLocation + "\Env.Config\" + $region)))
		{
			$localPackageConfig = $($local.FullName + "\Packages\" + $p.Name + "\Config")
			if (Test-Path (Split-Path $localPackageConfig -parent))
			{
				$destination = $($deployer.BuildData.DropLocation + "\Env.Config\" + $region + "\" + $p.Name)
			
				foreach ($file in (get-childitem $localPackageConfig | where-Object {!$_.Mode.Contains("d")}))
				{
					remove-item $(Join-Path $destination $file.Name) -force
					copy-item -path $file.FullName -destination $destination
				}
			}
			else
			{
				$deployer.logger.log($("No env.config cnf found for " + $localPackageConfig ), "warning", "4201")
				
			}
		
		}
	
	}
}

if ($wasLocPathGet)
{
	remove-Item $(Join-Path $local.FullName "*") -force -recurse
}

if ((Test-Path (Join-Path $deployer.BuildData.DropLocation $("Env.Config\" +  $deployRegion.FullName))) -or 
	$fullUpdate)
{
	[string] $envConfig = "\Env.Config"
	
	if (!$fullUpdate)
	{
		$envConfig += "\" + $deployRegion.FullName
	}
	
	$ws = .\Get-FromTFVC.ps1 $local.FullName $("$/" + $deployer.BuildData.TeamProject + "/TeamBuildTypes/" + $deployer.BuildData.BuildType + $envConfig)
	
	$dest = $($deployer.BuildData.DropLocation + $envConfig)
	
	if ($iswM -and $fullUpdate)
	{
		.\Sync-Directories.ps1 $local.FullName $dest | Out-Null
	}
	else
	{
		remove-Item $(Join-Path $dest "*") -force -recurse
		copy-item -Path $(Join-Path $local.FullName "*") -force -recurse -destination $dest
	}
}

#clean up 
Remove-item $local.FullName -recurse -force

$deployer.logger.log("Build Package is up-to-date", "config")