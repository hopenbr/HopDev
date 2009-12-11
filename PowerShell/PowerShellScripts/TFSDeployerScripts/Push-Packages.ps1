param($deployer = $(throw 'Error:  SRM TFS Deployer object is required'))

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 

function clean-deployArea ($_cleanPath)
{
	if ($deploymentOptions.Clean -eq "true")
	{
		$deployer.logger.log($("Cleaning Deployment area: " + $_cleanPath), "debug")
		
		remove-item $(Join-path $_cleanPath "*") -force -recurse
	}
	else
	{
		$deployer.logger.log("No Clean needed", "debug")
	}
}


function get-SyncOptions ([string] $syncType)
{
	[string] $syncOpts = "--ignorewarnings --notime "
	switch ($syncType) 
	{
		"Mirror"
		{
			$syncOpts += "--force"
		}
		"Full" 
		{
			$syncOpts += "--delete:y --overwrite:y --synctime:n --rename:n"
		}
		"ChangesOnly" 
		{
			$syncOpts += "--delete:n --overwrite:y --synctime:n --rename:n"
		}
		default 
		{ #changesOnly
			$syncOpts += "--delete:n --overwrite:y --synctime:n --rename:n"
		}
	}
	
	return $syncOpts
}

function invoke-Sync ([string] $source, [string] $target, [hashtable] $options)
{
	[string] $syncSw = $options.SyncOptions
	
	[string] $outFile = $(Join-Path $deployer.LogDir.FullName ($($options.SyncType) + "_" + $(Split-Path $path -Leaf) + "_" + $(Get-Date).ToString("yyyyMMdd_hhmmss") + ".log"))
	
	"Sync Switches: $syncSw" | Out-File -Append -Encoding ASCII -FilePath $outFile
					
	java -jar $($deployer.HppTools.Sync.FullName) $syncSw.Split(" ") $source $target 2>&1 | 
		Out-File -Append -Encoding ASCII -FilePath $outFile
	
					
}

function check-Environment ([string] $_e)
{
	if ($_e.Equals("In-QA2") -or $_e.Equals("In-TST1"))
	{
		if (!(Test-Path (Join-Path $deployer.BuildData.DropLocation $("Env.Config\" + $_e))))
		{
			if ($_e.Equals("In-QA2"))
			{
				$_e = "In-SystemTest02"
			}
			elseif ( $_e.Equals("In-TST1"))
			{
				$_e = "In-SystemTest01"
			}
		}  
		
	}
	
	return $_e
}

function push-Package([string] $path, [string] $_env, [string] $key)
{
	$deployer.logger.log("In push-Package", "debug")
	
	[int] $untilCount = 0
	[bool] $deploymentConfirmed = $false
	
	if ($deploymentOptions.ContainsKey("Confirm") -and 
		$deploymentOptions.Confirm -ne "true")
	{
		$deploymentConfirmed = $true
	}
	
	$_env = check-Environment $_env
		
	do 
	{
		[bool] $isPushNeeded = $true
		[bool] $isHintPathNeeded = $false
		[string] $hintPath;
			
		#code push
		if ($deployer.BuildData.BuildQuality.StartsWith("Deploy2"))
		{
			clean-deployArea $path
			$Files2Copy = $deployer.BuildData.DropLocation + "\Precompiled\" + $key
			[int] $whileCount = 0;
			while (!(resolve-path $Files2Copy -ea silentlycontinue).path -and $whileCount -le 1)
			{
				switch ($whileCount)
				{
					0 
					{ 
						$Files2Copy = $deployer.BuildData.DropLocation + "\" + $key	            
					}
					Default 
					{#should only get this is the two options are not found this means that the move is 
					#only configurable (Env.Config) deploys
					
						if ($_env.Contains("IRB"))
						{ #now we need to check to ensure it is not a IRB deploy if so we need to create the 
						#folder in TFVC  which will get the config pushed to it below
							mkdir $($path + "\" + $key)
							$path += "\" + $key
							$isPushNeeded = $false
						}
						
						$whileCount = 2
						$isPushNeeded = $false
					}
				}
				
				$whileCount++
					
			}
			
			if ($isPushNeeded)
			{
				if ($iswebMethodsPush)
				{
					push-wM $path $Files2Copy
				}
				else
				{
					invoke-Sync $Files2Copy $path $deploymentOptions
				}
			}
			
		}
		else
		{
			#not a full deployment only configs are being pushed
			#not need to confirm
			$deploymentConfirmed = $true
		}
		
		#push configs 
		[bool] $isConfigs2CopyRecursive = $true
		$Configs2Copy = $deployer.BuildData.DropLocation + "\Env.Config\" + $_env + "\" + $key
		$whileCount = 0;
		
		if ($iswebMethodsPush -and $deployer.DeploymentType -ne "full")
		{
			push-wM $path $($deployer.BuildData.DropLocation + "\" + $key)
		}
		
		while (!(resolve-path $Configs2Copy -ea silentlycontinue).path -and $whileCount -le 2)
		{
			switch ($whileCount)
			{
				0 
				{ 
					$Configs2Copy = $deployer.BuildData.DropLocation + "\Env.Config\" + $_env + "\" + $key + "site"	            
				}
				1 
				{
					$Configs2Copy = $deployer.BuildData.DropLocation + "\Env.Config\" + $_env + "site"
				}  
				2
				{
					$Configs2Copy = $deployer.BuildData.DropLocation + "\Env.Config\" + $_env
					$isConfigs2CopyRecursive = $False
				}
			}
		    
			$whileCount++
		         
		}
				
		if (Test-Path $Configs2Copy)
		{
			[string] $syncSwitches = Get-SyncOptions "ChangesOnly"
			
			 
			if (-not $isConfigs2CopyRecursive)
			{
				 $syncSwithces += " --norecurse"
			}
			
			$dopts = @{"SyncType" = "Configs";
					   "SyncOptions" = $syncSwitches}
			
			invoke-Sync $Configs2Copy $path $dopts
			
			$isHintPathNeeded = $true
			$hintPath = $Configs2Copy
				
		}
		
		$untilCount++
		if ($isPushNeeded -and !$deploymentConfirmed)
		{
			$deployer.logger.log($("Confirming Deployment to " + $path + " by comparing to source directory " + $Files2Copy + "`n`nDAta Info:`nConfig ==> " + $configs2Copy + "`nHintPAth ==> " + $hintPath), "config")
			
			if ($isHintPathNeeded -and $hintPath)
			{
				$deploymentConfirmed = Compare-Directories -SourceDirectory $Files2Copy -DeploymentDirectory $path -EnvConfigPath $Configs2Copy -ConfigHintPath $hintPath -deployment $true 
			}
			else
			{
				$deploymentConfirmed = Compare-Directories -SourceDirectory $Files2Copy -DeploymentDirectory $path -EnvConfigPath $Configs2Copy -deployment $true
			}
		}
		else
		{
			$deploymentConfirmed = $true
		}
		
	} until ($deploymentConfirmed -or $untilCount -gt 2)
	
	if (!$deploymentConfirmed)
	{
		[string] $err =  $("Error: TFS Deployer could not comfirm the Deployment area, " +
		        "by comparing it to the deployment source area, Three deployment attempts were made." +
		        "`n`nError info:`n" +
		        "Path ==> " + $path + "`n" +
		        "ENV ==> " + $_env + "`n" +
		        "Key ==> " + $_key + "`n")
				
		$deployer.logger.log($err, "error")
		
		throw $err
	}
	else
	{
		$deployer.logger.log("Deployment confirmed", "config")
	}
} 

function push-Package2TFVC([string] $path, [string] $_key)
{
	#push file to local temp area where workspace will be mapped and used to added to TFVC
	$path, $_cleanCmd = $path.split(";")
	$pushPath = $path + "\" + $deployer.BuildData.BuildNumber 
	$isThere = (resolve-path $pushPath -ea silentlycontinue).path
	write-debug "PATH for TFVC push: $pushPath"
	
	
	if (!$isThere)
	{
		new-item -path $path -name $deployer.BuildData.BuildNumber -type directory | out-null
	}
	
	if (!(resolve-path $(Join-path $pushPath "$_key") -ea silentlycontinue).path)
	{
		new-item -path $pushPath -name $_key -type directory | out-null
	}
	else
	{
		write-debug "TFVC workspace temp are to be cleaned"
			
		remove-item $(Join-path $pushPath "$_key\*") -force -recurse | out-null
	}
	
	$pushPath += "\" + $_key 
	
	push-Package $pushPath "In-Production" $_key
	
}


#this push is not using sync b/c we are only moving one file 
#and the deployment Area has 100s of file no need to waste the 
#effort of a sync comparison for one file
function push-wM ([string] $_pushPath, [string] $_files2copy)
{
	[bool] $_compare = $false
	[int] $fileCount = @(Get-childitem $_files2Copy -include "*.zip" -recurse).Count
	
	if ($fileCount -gt 1)
	{
		$_compare = $true
	}
	elseif ($fileCount -eq 0)
	{
		[string] $err = $("Error: wM Build package folder (" + $_files2copy + ") is empty")
		
		$deployer.logger.log($err, "error")
		
		throw $err
	}
	
	$deployer.logger.log("wM Deploy copy file: $_files2Copy", "debug")
	
	foreach ($file in (Get-Childitem $_files2copy))
	{
		$wMDeployMapping = @{}
		
		if ($deployer.Env.Equals("In-IRB"))
		{
			$deployer.logger.log("In IRB push of wM", "debug")
			
			Copy-item -path $file.FullName -destination $_pushPath -force
			
			[string] $ecDest = (Join-Path (Split-Path $_pushPath -parent) "Env.Config\PRD")
		
			if (Test-Path $ecDest)
			{
				#if ...\Env.Config\PRD is there remove ENV.PRD config in should not be there
				
				remove-item -path (Split-Path $ecDest -parent) -force -recurse
			}
			
			copy-item -Path (Join-Path $deployer.BuildData.DropLocation "Env.Config\PRD") -Destination $ecDest -recurse
		
			
		}
		else
		{
			[bool] $pushNeeded = $true
			
			$targetfile = $($_pushPath + "\" + $file.Name)
			
			$deployer.logger.log("wM Deploy target file: $targetfile", "debug")
			
			if (Test-Path $targetfile)
			{
				if ($_compare)
				{
					if((Compare-files $targetfile $file.FullName))
					{
						$pushNeeded = $false
					}
					else
					{
						Remove-Item $targetfile -force		
					}
				}
				else
				{
					if ($deployer.DeploymentType -eq "full")
					{
						Remove-Item $targetfile -force
					}
				}
			} 
			
			if ($pushNeeded)
			{
				$package_name = $file.Name.Remove($($file.Name.Length - $file.Extension.length))
				
				if($wMDeployHash.ContainsKey($package_name))
				{
					$wMDeployHash.$package_name.Target += $("," + $_pushPath)
				}
				else
				{
					$wMDeployMapping.Add("Source", $file.FullName)
					$wMDeployMapping.Add("Target", $_pushPath)
					$wMDeployHash.Add($package_name, $wMDeployMapping)
				}
				
			}
		}			
	}
	 
}

function push-PackageFromTFVC( [string] $_pushPath, $_key)
{
	[bool] $deploymentConfirmed = $false;
	[int] $doCount = 0;
	[bool] $isConfirmationNeeded = & { if ($deploymentOptions.ContainsKey("Confirm") -and $deploymentOptions.Confirm -ne "true"){$false}else{$true} }
	
	$Files2Copy = $ws + "\" + $_key
	
	do 
	{
		if ($iswebMethodsPush)
		{
			push-wM $_pushPath $Files2Copy
		}
		else 
		{
			$dopts = @{}
			
			if ($deployer.BuildData.BuildQuality.StartsWith("Deploy2"))
			{
				clean-deployArea $_pushPath
				$dopts = $deploymentOptions
			
			}
			elseif ($deployer.BuildData.BuildQuality.StartsWith("Configs2"))
			{
				$dopts = @{"SyncType" = "Configs2";
					       "SyncOptions" = $(get-SyncOptions "ChangesOnly")}
			}
			
			invoke-Sync $Files2Copy $_pushPath $dopts
		}
			
		$doCount++
		if ($isConfirmationNeeded)
		{
			$deployer.logger.log($("Confirming deployment:`nDeploy area => " + $_pushPath + "`nSource area => " + $Files2Copy), "config")
			$deploymentConfirmed = Compare-Directories -SourceDirectory $Files2Copy -DeploymentDirectory $_pushPath
		}
		else
		{
			$deployer.logger.log("No deployment confirmation: May be a deployment to a non-cleaned area", "config")
			$deploymentConfirmed = $true
		}
		
	}until ($deploymentConfirmed -or $doCount -gt 2)
	
	if (!$deploymentConfirmed)
	{
		[string] $err = $("Error: TFS Deployer could not comfirm the Deployment area, " +
		        "by comparing it to the deployment source area, Three deployment attempts were made." +
		        "`n`nError info:`n" +
		        "Deploy Path ==> " + $_pushPath + "`n" +
		        "Source Path ==> " + $Files2Copy + "`n" +
		        "ENV ==> In-Production`n" +
		        "Key ==> " + $_key + "`n")
				
			$deployer.logger.log($err, "error")
			
			throw $err
	}
	else
	{
		$deployer.logger.log("Deployment confirmed", "config")
	}
	
	#TODO: delete local workspace files
}

function recycle-AppPool ([string] $appPoolName, [string] $serverName)
{
   $deployer.logger.log($($deployer.BuildData.BuildNumber + " Recycling IIS://$serverName/.../$appPoolName"), "config")
   
	[string] $returnStr = ""
	
	if ($appPoolName)
	{
		if (!$serverName)
		{
			$returnStr += "AppPool recycle skipped:`n AppPoolName => $appPoolName `n Server => $serverName"
		}
		else
		{ 
			$returnStr += "<br>"
			$returnStr += .\Recycle-AppPool.ps1 $serverName $appPoolName	
		}
	}
	else
	{
		$returnStr = "No AppPools to recycle on $serverName"
	}
	
	$deployer.logger.log($returnStr, "debug")
	
	return $returnStr                                                                                                                                                                                                                 
}


function which-Push ([string] $_pushPath, [string] $packageName)
{
	$deployer.logger.log($($deployer.BuildData.BuildNumber + " Deploying to " + $_pushPath), "config")
	
	if (!(Test-Path $_pushPath))
	{
		Throw "Error: Invalid Region Location path; $_pushPath is an invalid path"
	}
			
	if ($deployer.env.Equals("In-IRB"))
	{
		push-Package2TFVC $_pushPath $packageName
	}
	elseif ($deployer.env.Equals("In-Production"))
	{
		push-PackageFromTFVC $_pushPath $packageName
	}
	else
	{
		push-Package $_pushPath $deployer.Env $packageName
	}
	
	$deployer.logger.log($("Deployment of " + $deployer.BuildData.BuildNumber + "to " + $_pushPath + "Complete"), "debug")
}


function parse-DeploymentPath ($_package)
{

	$deployer.logger.log($("Parsing: " + $path2parse), "debug")
	 
	$opts = @{}
	
	$_package | gm -type Property |%{$opts.Add($_.Name, $_package.$($_.Name))}		 
	
	#Need to support v1 of Deploymentconfig Xml
	#that use clean which was deprecaped in HPP 2.0 
	#
	if ($opts.ContainsKey("Clean"))
	{
		if ($opts["Clean"] -eq "true")
		{
			$opts.Add("SyncType", "Mirror")
			
			$opts["Confirm"] = "true"
		}
		else
		{
			$opts.Add("SyncType", "ChangesOnly")
			
			$opts["Confirm"] = "false"
		}
		
		$opts["Clean"] = "false"
	}
	
	#only types of deploys that need confirmation are Simple or .Net
	if (-not ($opts["DeploymentType"] -match "Simple|\.Net"))
	{
		$opts["Confirm"] = "false"
	}
	
	#now check to see if a force clean is in the options 
	
	if ($_package.Options -and
		$_package.Options.SelectSingleNode("Option[@Key='ForceClean']") -and
		$_package.Options.SelectSingleNode("Option[@Key='ForceClean']").Value -ne "false")
	{
		#here we are allowing a clean for items that may have a huge 
		#comparison cost, the main one is AQS Helpfiles 1000+ difference 
		$opts["Clean"] = "true"
	}
	
	#now check to see if a deploy confirm is not needed
	
	if ($_package.Options -and
		$_package.Options.SelectSingleNode("Option[@Key='DeploymentConfirmation']") -and
		$_package.Options.SelectSingleNode("Option[@Key='DeploymentConfirmation']").Value -eq "false")
	{
		#here we are allowing a an override of the confirm task to turned off on 
		#full or mirrored deployments
		$opts["Confirm"] = "false"
	}
	
	
	$opts.Add("SyncOptions", $(get-SyncOptions $opts["SyncType"]))
	
	$deployer.logger.log($("Parsed:`n" + $($opts.keys | foreach-object {$_ + " => " + $opts.$_ + "`n"}) ), "config")
	
	return $opts
	
}

##MAIN####

#needed to comfirm the deploy
add-pssnapin Harleysville.Deployment.SnapIn -ea silentlycontinue
$wMDeployHash = @{}
[bool] $iswebMethodsPush = $false
$deploymentOptions = @{}
[int] $packageCount = 0

if ($deployer.env.Equals("In-Production"))
{
    $deployer.logger.log($($deployer.BuildData.BuildNumber + " being deployed to PRD, build package being downloaded form TFVC"), "config")
	[string] $ws = .\TFSDeployerScripts\Get-BuildPackageFromTFVC.ps1 $deployer.BuildData.TeamProject $deployer.BuildData.BuildNumber
	if (!$ws -or !(Test-Path $ws))
	{
		[string] $err = "ERROR: There was an error getting code from TFVC; Please ensure build package was properly deploy to IRB"
		$deployer.logger.log($err, "error")
		throw $err
	}
}

foreach ($package in $deployer.DeploymentConfig.Settings.Packages.Package)
{
	if ($package.Deploy -ne "true")
	{
		continue
	}
	else
	{
		$packageCount++
	}

	$deploymentOptions = parse-DeploymentPath $package
	
	if ($deploymentOptions.DeploymentType -eq "EAR" -and !$deployer.env.equals("In-IRB"))
	{
		$deployer.logger.log("EAR deployment; calling EAR/WAS deployment scripts", "info")
		.\TFSDeployerScripts\Deploy-Ear.ps1 $deployer $deploymentOptions.PackageName
		continue
	}
	elseif ($deploymentOptions.DeploymentType -eq "webMethods")
	{
		$deployer.logger.log(("Package deployment is of type webMethods"), "info")
		$iswebMethodsPush = $true
	}
	
	if ($deployer.env.equals("In-IRB"))
	{
		if (!(Test-Path $deployer.Config.Deployment.TempLocation))
		{
			new-item -path $(Split-path $deployer.Config.Deployment.TempLocation -parent) -name $(Split-path $deployer.Config.Deployment.TempLocation -leaf) -type directory| out-null
		}
		
		which-Push $deployer.Config.Deployment.TempLocation $deploymentOptions.PackageName
	}
	else
	{
		if (!($package.DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']")))
		{
			[string] $err = "Error: No deployment locations found for Deployment region: " + $deployer.RegionName.Name
			
			$deployer.logger.log($err, "error")
			
			throw $err
		}
		
		if ($package.DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").RecycleAppPools)
		{
			foreach ($appPool in $package.DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").RecycleAppPools.AppPool)
			{
				recycle-AppPool $appPool.GetAttribute("AppPoolName") $appPool.GetAttribute("IISServerName") | out-null
			}
		}
		
		foreach ($location in $package.DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").RegionLocations.Location)
		{		
			if ($location.Deploy -and 
				$location.Deploy -eq "false")
			{
				$deployer.logger.log($("Deployment of Package: " + $deploymentOptions.PackageName + " to Location: " + $location.Path + " was skipped due to location deploy attibute was set to false"), "config")
				$deployer.Message.AppendLine($("Deployment of Package: " + $deploymentOptions.PackageName + " to Location: " + $location.Path + " was skipped due to location deploy attibute was set to false")) 
			}
			else
			{
				$path = $location.Path 
				which-Push $path $deploymentOptions.PackageName
			}
		}
		
		if ($package.DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").RecycleAppPools)
		{
			foreach ($appPool in $package.DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$($deployer.RegionName.Name)']").RecycleAppPools.AppPool)
			{
				$deployer.Message.AppendLine($(recycle-AppPool $appPool.GetAttribute("AppPoolName") $appPool.GetAttribute("IISServerName")))
			}
		}
		
	}	
	   
	$deployer.logger.log($("End Deployment for " + $package.PackageName + " in " + $deployer.BuildData.BuildNumber), "config")
	
	if ($deploymentOptions.DeploymentType -eq "webMethods" -and !$deployer.env.Equals("In-IRB"))
	{
		$deployer.logger.log("webMethods deployment; calling webMethods deployment scripts", "config")
		.\webMethodsScripts\wM-deployer.ps1 $deployer
	}
}

if ($packageCount -eq 0)
{
	[string] $err1 = "ERROR: No packages within the Build package were deployed."
	$err1 += " Please ensure the DeploymentConfig has at least one sub package"
	$err1 += " to set to deploy"
	
	$deployer.logger.log($err1, "error")
	throw $($err1)
}

if ($deployer.env.Equals("In-IRB"))
{	
	$deployer.logger.log("Start deployment for IRB", "info")
	$localPath = (Join-Path $deployer.Config.Deployment.TempLocation $deployer.BuildData.BuildNumber)
	$serverPath = "$/" + $deployer.BuildData.TeamProject + "/Releases/" + $deployer.BuildData.BuildNumber
	[bool] $success = $false
	[bool] $relaseUpdate = $false
	
	if ($deployer.tfs.VCS.ServerItemExists($serverPath, [Microsoft.TeamFoundation.VersionControl.Client.ItemType]::Folder))
	{
		$releaseUpdate = $true
		$success = .\TFSDeployerScripts\Import-ReleaseChanges.ps1 $deployer $serverPath $localPath
	}
	else
	{
		$success = .\Add-2TFVC.ps1 $localPath $serverPath
	}
	
	if (!$success)
	{
		[string] $err = "Error: There was a problem adding the code to TFVC"
		
		if ($releaseUpdate)
		{
			$err += " No source code differences were found between Release code in TFVC and Build package"
		}
		
		$deployer.logger.log($err, "error")
		throw $($err)
		
	}
	
	$deployer.logger.log($($deployer.BuildData.BuildNumber + " Build package build deployed to TFVC Release area (" + $serverPath + ")"), "info")
	remove-item -path $localPath -recurse -force 
}

if ($deployer.env.Equals("In-Production"))
{
    remove-item -path $ws -force -recurse
}

