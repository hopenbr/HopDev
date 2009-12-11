####Sync-Database.ps1 
#this script will sync the builds TFVC Scripts folder to the Regions DB
#it will use RedGate's SQL Compare Pro 7 to sync the DB 
#
#

param($deployer = $(throw 'The SRM HPP TFSDeployer obj is required'))

function get-ErrorMsg ([int] $exitCode)
{

# These messages were copied from the SQLCompare.exe -help section 
#if SQL Compare is updated need to ensure that the below holds true

	[string] $errMsg = "" 
	
	switch ($exitCode)
	{ 
		1 { $errMsg = "General error code." }
		3 { $errMsg = "Illegal argument duplication. Some arguments may not appear more than once in a command-line. If such arguments appear more than once this exit code will be returned." }
		8 { $errMsg = "Unsatisfied argument dependency or violated exclusion when user runs command line. E.g. /arg2 depends on /arg1 but you have specified /arg2 without specifying /arg1, or alternatively /arg2 cannot be used with /arg1 but you have tried to use them both." }
		32 { $errMsg = "Value out of range. Numeric value supplied for an argument that is outside the range of valid values for that argument." }
		33 { $errMsg = "Value overflow. The magnitude of a value supplied for an argument is too large and causes an overflow." }
		34 { $errMsg = "Invalid value. The value supplied for an argument is invalid." }
		35 { $errMsg = "No / invalid software license or trial period has expired." }
		63 { $errMsg = "The databases being compared are identical with respect to any constraints on objects being compared." }
		64 { $errMsg = "General command-line usage error." }
		65 { $errMsg = "Data error. Some input data required by the tool is invalid or corrupt." }
		69 { $errMsg = "A resource or service required to run the tool is unavailable." }
		73 { $errMsg = "Failed to create report" }
		74 { $errMsg = "IO error occurred. Generally returned if the program attempts to write to a file that already exists without the user having specified the /force option." }
		77 { $errMsg = "Action cannot be completed because the user does not have permission." }
		126 { $errMsg = "Execution failed because of an error." }
		130 { $errMsg = "Execution stopped because Ctrl+Break." }

	}
	
	return $errMsg
}

function get-LogTypeExt ($type)
{

# This report information was obtained from the SQLCompare.exe -help section 
#if SQL Compare is updated need to ensure that the below holds true

	switch ($type)
	{
		"XML" {return ".xml"}
		"Simple" {return ".html"} 
		"Interactive" {return ".html"}
		"Excel" {return ".xls"}
		Default {throw "Error: Unknown Reporttype passed in" }

	}
}

###MIAN###
[void] [Reflection.Assembly]::LoadWithPartialName("Microsoft.TeamFoundation.VersionControl.Client")

$deployer.Logger.Log("In Sync-Database", "debug")

#get the configuation directory for this build and the deployment region
New-Variable -Name envDBDir
[bool] $foundEnvDir = $true 

$envDBDirPath = $(Join-Path $deployer.BuildData.DropLocation $("Env.Config\" + $deployer.RegionName.FullName + "\DB" ))

if (-not (Test-Path $envDBDirPath))
{
	$foundEnvDir = $false
}
else
{
	$envDBDir = Get-Item $envDBDirPath
}

[int] $syncCount = 0

#search throught all databases in deploymentconfig.xml
foreach ($db in $deployer.deploymentConfig.Settings.Databases.Database)
{
	#$db is Database xml element
	#refer to ..\TFSDeployerConfigMapping.xsd for structure
	
	$deployer.Logger.Log("Searching Databases", "debug")
	[bool] $useDefaultArgs = $false
	
	[string] $sqlArgsXmlFileName = "Default_SQLCompArgs.xml"
	
	if ($($db.GetAttribute("SqlCompareArgsXmlName")))
	{
		$sqlArgsXmlFileName = $($db.GetAttribute("SqlCompareArgsXmlName")) -as [string]
	}
	
	[string] $sqlArgsXmlFile = $(Join-Path $envDBDirPath $sqlArgsXmlFileName)
	
	if ($($db.GetAttribute("Region")) -eq $deployer.RegionName.Name -and 
		$($db.GetAttribute("Sync")) -eq "true")
	{
		if (-not $foundEnvDir -or 
		    -not (Test-Path $sqlArgsXmlFile))
		{
			if ($db.GetAttribute("ServerName") -and
				$db.GetAttribute("DatabaseName"))
			{
				$deployer.logger.log("Using Default SQL Compare Argument XML", "Debug")
				
				$useDefaultArgs = $true
				
				[string] $defaultSeverPath = $($deployer.Config.Deployment.ServerPaths.DefaultSQLCompareArgsXml)

				[string] $defaultTemp = $($deployer.Config.Deployment.TempLocation + "defaultSqlArgs.xml")

				$deployer.Tfs.VCS.DownloadFile($defaultSeverPath, $defaultTemp)
				
				$sqlArgsXmlFile = $defaultTemp
			}
			else
			{
				[string] $errMsg = "Error: "
				if (-not $foundEnvDir)
				{
					$errMsg += "Invalid DB Config folder path at $envDBDirPath"
				}
				else
				{
					$errMsg += "Invalid SQL Compare Argument Xml path at $sqlArgsXmlFile"
				}
				
				$errMsg += " To use default Args ServerName and DatabaseName attributes need to be set in Database node in DeploymentConfig.xml"
				
				$deployer.Logger.Log($errMsg, "error")
				throw $errMsg
			}
		}
		
		$syncCount++
		
		[bool] $schemaOnly = $false
		[bool] $separatedScriptsFolder = $false
		
		$deployer.Logger.Log($("DB found: " + $($db.GetAttribute("Name"))), "debug")
		
		#get the Args Xml file for SQL Compare Pro CmdLine
		$sqlCompArgs = Get-Item $sqlArgsXmlFile
		
		if (!$sqlCompArgs.Exists)
		{
			throw "Error: Invalid path, could not find file ($sqlCompArgs)"
		}
		
		#read the contents of the xml into an xml object [System.Xml.XmlDocument]
		[xml] $scaXml = [xml] $(Get-Content $sqlCompArgs)
		
		if($useDefaultArgs)
		{
			#using default args means we need to set the DB server and Database
			#args, 
			
			$scaXml.commandline.server2 = $db.GetAttribute("ServerName") -as [string]
			$scaXml.commandline.database2 = $db.GetAttribute("DatabaseName") -as [string]
			$scaXml.commandline.Scripts1 += "_" + $scaXml.commandline.server2 + "_" + $scaXml.commandline.database2
		}
		
		if ((Test-Path $scaXml.commandline.Scripts1))
		{
			$deployer.Logger.Log("Cleaning DB workspace area", "debug")
			Remove-Item -Path $scaXml.commandline.Scripts1 -Recurse -Force
		}
		
		#ensure the TFS Server path is valid 
		if (!$deployer.TFS.VCS.ServerItemExists($($db.GetAttribute("TFVCServerPath")), [Microsoft.TeamFoundation.VersionControl.Client.ItemType]::Folder))
		{
			throw "Error: Invalid TFVC path, could not find server path to scripts folder at " + $($db.GetAttribute("TFVCServerPath"))
		}
		
		if (!$deployer.TFS.VCS.ServerItemExists($($db.GetAttribute("TFVCServerPath") + "/Schema"), [Microsoft.TeamFoundation.VersionControl.Client.ItemType]::Folder))
		{
			#Checked to see if there was a schema folder under the TFVC Server Path
			#passed in, if not, we assume that Schema Scripts folder is direct 
			#path they gave us, now we can check to see if the deployment
			#scripts folder where the pre and post scripts are held is added 
			#in the options. If so, we'll set it as a separated folder and setup the
			#local workspace as if they were together
			#otherewise this deploy is for schema sync only 
			
			if($db.Options -and
			   $db.Options.SelectSingleNode("Option[@Key='DeploymentScriptsFolder']"))
			{
				#note this will allow us to have a comon deployment scripts area 
				#not sure if it will help us but it may 
				
				[string] $scriptsServerPath = $db.Options.SelectSingleNode("Option[@Key='DeploymentScriptsFolder']").Value -as [string] 
				
				if (-not $deployer.TFS.VCS.ServerItemExists($scriptsServerPath, [Microsoft.TeamFoundation.VersionControl.Client.ItemType]::Folder))
				{
					throw "Error: Invalid TFVC path, could not find server path to deployment scripts folder at $scriptsServerPath"
				}
				
				$separatedScriptsFolder = $true
				
				[string] $downDir = Join-Path $($scaXml.commandline.Scripts1) "Scripts"
			
				$deployer.Logger.Log("Getting deployemnt Scripts folder from TFVC: $scriptsServerPath to $downDir", "debug")
		
				
				#2009-10-13
				##Adding standalone DB build coupling via a small scirpt housed
				##in the build package of the coupled/deployment build package
				[string] $buildLabel = $($deployer.BuildData.BuildNumber)
				[string] $buildCoupleScript = Join-Path $deployer.BuildData.DropLocation "Get-DBLabel.ps1"
				
				if ($(Test-Path $buildCoupleScript))
				{
					#sciprt found and how need to run it passing the 
					#TFVC server path that be need a label for 
					
					$buildLabel = & $buildCoupleScript $scriptsServerPath
					
					if ($buildLabel -eq $null)
					{
						throw "Error: DB Build Coupling could not get label for $scriptsServerPath"
					}
				}
				
				
				#this scritpt will download the labeled elements from TFVC
				
				.\Get-FromTFVC.ps1 $downDir $scriptsServerPath $buildLabel | out-null

				$deployer.Logger.Log("deployment Scripts Folder downloaded to $downDir", "debug")
		
			
			}
			else
			{
				$schemaOnly = $true
			}
				
		}
		
		[string] $downLoadDir = $($scaXml.commandline.Scripts1)
		
		if ($schemaOnly -or 
		    $separatedScriptsFolder)
		{
			$downLoadDir += "\Schema"
		}
		
		$deployer.Logger.Log("Getting Schema Scripts folder from TFVC: " + $($db.GetAttribute("TFVCServerPath")) + " to " + $downLoadDir, "debug")
		
		#this scritpt will download the labeled elements from TFVC
		.\Get-FromTFVC.ps1 $downLoadDir $($db.GetAttribute("TFVCServerPath")) $($deployer.BuildData.BuildNumber) | out-null

		$deployer.Logger.Log("Schema Scripts Folder downloaded to $downLoadDir", "debug")
		
		#above work was to get standard folder structure set up 
		#make it easier to work with here 
		[string] $wsFolder = $scaXml.commandline.Scripts1
		[string] $scriptsPath = $(Join-Path $($scaXml.commandline.Scripts1) "Scripts")
		[string] $schemaPath = $(Join-Path $($scaXml.commandline.Scripts1) "Schema")
		[string] $sqlCompareArgsPath = $(Join-Path $($scaXml.commandline.Scripts1) "args.xml")
		[string] $sqlCompareArgsPath_noCon = $(Join-Path $($scaXml.commandline.Scripts1) "args_NoConstraints.xml")
		[string] $sqlCompareArgsPath_up = $(Join-Path $($scaXml.commandline.Scripts1) "args_UpScript.xml")
		[string] $redGateInfoXmlName = "SqlCompareDatabaseInfo.xml"
		
		#check to ensure that code was downloaded, ensure the TFVC server path was label with the build number
		if (!(Test-Path $(Join-Path $schemaPath $redGateInfoXmlName)))
		{	
			throw "Error: No Scripts Folder code with label $($deployer.BuildData.BuildNumber) was found"
		}
		
		#need to update args xml to schema location 
		$scaXml.commandline.Scripts1 = $schemaPath

		#run pre-deployment scripts
		
		if ($deployer.AddinScripts["AfterGetDBScriptsFolder"].Run)
		{#call override/addin scripts if there is one
			$deployer.logger.log("CallIng AddIn AfterGetDBScriptsFolder", "debug")
			
			$deployer.AddinScripts["AfterGetDBScriptsFolder"].Exec() | out-null
		}
		
		[string] $connectionString="data source=$($scaXml.commandline.server2);Initial Catalog=$($scaXml.commandline.database2);User ID=$($deployer.SqlDeployer.Username);pwd=$($deployer.SqlDeployer.Password);"
		
		#ensure sync connects as the SQLDeployer who have sysadmin rights 
		if (-not $scaXml.commandline.username2)
		{
			$scaXml.commandline.AppendChild($($scaXml.CreateElement("username2"))) | out-null
		}
		
		if (-not $scaXml.commandline.password2)
		{
			$scaXml.commandline.AppendChild($($scaXml.CreateElement("password2"))) | out-null
		}
		
		$scaXml.commandline.username2 = $deployer.SQLDeployer.Username -as [string]
		$scaXml.commandline.password2 = $deployer.SQLDeployer.Password -as [string]
		
		#run Search and Replace if needed
		if ($($db.GetAttribute("SearchAndReplace")) -eq "True")
		{
			.\TFSDeployerScripts\Invoke-SqlSearchAndReplace.ps1 $wsFolder $deployer
		}
		
		$syncLogs =  $(Join-Path $deployer.BuildData.Droplocation $("DatabaseSyncLogs\" + ($db.Name -as [string])))
		
		if (!$(Test-Path $syncLogs))
		{
			New-Item -Name $(Split-Path $syncLogs -Leaf) -Path $(Split-Path $syncLogs -Parent) -Force -ItemType directory | out-null
		}
		
		#report time, need to ensure that a report is generated 
		#default is simple which creates a html report 
		#but if the args file has something else we need to account for that
		
		[string] $logTypeExt = ".html"
		
		if ($scaXml.commandline.reporttype)
		{
			$logTypeExt = get-LogTypeExt $scaXml.commandline.reporttype
		}
		else
		{
			$scaXml.commandline.AppendChild($($scaXml.CreateElement("reporttype"))) | out-null
			
			$scaXml.commandline.reporttype = "Interactive"
		}
		
		#set all the output file up
		[string] $outputlog = $(Join-Path $syncLogs $("Sync_" + $($scaXml.commandline.Database2) + "_" + $($scaXml.commandline.Server2) + "_" + $(Get-Date).ToString("yyyyMMdd_hhmmss") + $logTypeExt))
		[string] $outputlog_noCon = $(Join-Path $syncLogs $("Sync_" + $($scaXml.commandline.Database2) + "_" + $($scaXml.commandline.Server2) + "_NoConstraints_" + $(Get-Date).ToString("yyyyMMdd_hhmmss") + $logTypeExt))
		[string] $outputResults = $(Join-Path $syncLogs $("Sync_" + $($scaXml.commandline.Database2) + "_" + $($scaXml.commandline.Server2) + "_" + $(Get-Date).ToString("yyyyMMdd_hhmmss") + ".log"))
		[string] $upScript = $(Join-Path $syncLogs $("UpScript_" + $($scaXml.commandline.Database2) + "_" + $($scaXml.commandline.Server2) + "_" + $(Get-Date).ToString("yyyyMMdd_hhmmss") + ".sql"))
		
		#now they are set week need to populate them
		
		if (!$scaXml.commandline.Report)
		{
			$scaXml.commandline.AppendChild($($scaXml.CreateElement("report"))) | out-null
		}
		
		if ($scaXml.commandline.options)
		{ #if custom options are enable in the args xml ensure the default one
		#are enabled as well 
		
			[string] $opts = $scaXml.commandline.options
			
			$deployer.logger.log("Checking custom options; $opts", "Debug")
			
			foreach($do in $($deployer.Config.Deployment.RedGate.SyncOptions.Default).split(","))
			{
				if (-not ($opts -match $do))
				{
					$deployer.logger.log("adding $do option to sync options argument", "Debug")
					$scaXml.commandline.options += ",$do"
				}
			}
			
		}
		else
		{
			$scaXml.commandline.AppendChild($($scaXml.CreateElement("options"))) | out-null
			
			$scaXml.commandline.options = $($deployer.Config.Deployment.RedGate.SyncOptions.Default)
		
		}
		
		#need check excludes for roles, users and rules 
		
		if($scaXml.commandline.exclude)
		{
			foreach($ex in $($deployer.Config.Deployment.RedGate.ExcludeItems).split(","))
			{
				if (-not ($scaXml.commandline.exclude -match $ex))
				{
					$deployer.logger.log("adding $ex to excluded items", "info")
					
					$e = $scaXml.CreateElement("exclude")
					$e.set_InnerText($ex)
					
					$scaXml.commandline.AppendChild($e)
				}
			}
			
		}
		else
		{
			foreach($ex in $($deployer.Config.Deployment.RedGate.ExcludeItems).split(","))
			{	
			
				$deployer.logger.log("adding $ex to excluded items", "info")
					
				$e = $scaXml.CreateElement("exclude")
				$e.set_InnerText($ex)
				
				$scaXml.commandline.AppendChild($e)
				
			}
		}
		
		
		$scaXml.commandline.report = $outputlog 
		
		$scaXml.Save($sqlCompareArgsPath)
		
		if ($scaXml.commandline.options)
		{
			[string] $opts = $scaXml.commandline.options
			
			$deployer.logger.log("Checking custom options for noConstraints; $opts", "Debug")
			
			foreach($do in $($deployer.Config.Deployment.RedGate.SyncOptions.NoConstraints).split(","))
			{
				if (-not ($opts -match $do))
				{
					$deployer.logger.log("adding $do option to sync options argument for no constraints syncs", "Debug")
					$scaXml.commandline.options += ",$do"
				}
			}
			
			
		}
		
		$scaXml.commandline.report = $outputlog_noCon
		
		$scaXml.Save($sqlCompareArgsPath_noCon)
		
		###create args for create Up script which is be saved in the buildStore
		#REASON for this is that I want an easy way to see what exact the 
		#sync did, plus in future may exam this file to look for 
		#drop, alters, etc to determin data loss risk 
		
		$scaXml.commandline.RemoveChild($scaXml.commandline.SelectSingleNode('synchronize')) | Out-Null
		$scaXml.commandline.RemoveChild($scaXml.commandline.SelectSingleNode('report')) | Out-Null
		$scaXml.commandline.RemoveChild($scaXml.commandline.SelectSingleNode('reporttype')) | Out-Null
		
		
		$scaXml.commandline.AppendChild($($scaXml.CreateElement("scriptfile"))) | out-null
		
		$scaXml.commandline.scriptfile = $upScript
		
		$scaXml.Save($sqlCompareArgsPath_up)
		
		pushd "$($deployer.Config.Deployment.Path2SqlCompareDir)"
		
		#get up script 
		
		$rs = .\sqlcompare.exe /argfile:"$($sqlCompareArgsPath_up)"
		
		$rs | Out-File -FilePath $outputResults -Force -Append
		
		#check for table drop
		#if drop found check to see if the DropActions is set for this
		#DB migration, 
		
		[bool] $backupNeeded = $true
		
		if ($($db.GetAttribute("Backup")) -eq "False")
		{
			$backupNeeded = $false
		}
		
		if (($rs | ?{$_ -match "^table" -and $_ -match "<<"}))
		{
			$tables2drop = ($rs | ?{$_ -match "^table" -and $_ -match "<<"})
			#tables will be dropped
			
			$deployer.logger.log("Warning: Tables will be dropped $tables2Drop", "debug")
			
			if ((-not $db.DropActions) -or
			    ($db.DropActions -eq "fail"))
			{
				[string] $dropmsg = "Error: Sync job will drop table, Check logs for more info $syncLogs; to allow set Databases\Database[DropActions] to 'Continue' or 'backup' in deployment config"
				$deployer.logger.log($dropmsg, "error")
				throw $dropmsg 
			}
			elseif (($db.DropActions) -and
			        ($db.DropActions -eq "continue"))
			{
				$deployer.logger.log("Warning: Tables will be dropped $tables2Drop", "Warning")
				$deployer.Message.AppendLine("Tables dropped $tables2Drop")
			}
			elseif (($db.DropActions) -and
			        ($db.DropActions -eq "backup"))
			{
				[string] $backupMsg = "Warning: table drops will occur backup before sync; tables: $tables2Drop"
				$deployer.logger.log($backupMsg, "debug")
				$deployer.Message.AppendLine($backupMsg)
				
				$backupNeeded = $true
			}
			
		}
		else
		{
			$deployer.logger.log("No table will be dropped", "debug")
		}
		
		#run pre deployment if available
		$deployer.logger.log("Check Pre sync actions", "debug")
		
		[System.IO.FileInfo] $preDeployScriptsXml = $(Get-Item $(Join-Path $scriptsPath "Pre-Deployment\PreDeployment.xml"))
		
		if ($preDeployScriptsXml.Exists)
		{
			popd
			$deployer.logger.log("Pre scripts will be run;  Backup set to $backupNeeded", "debug")
			.\TFSDeployerScripts\Invoke-SqlDeploymentScripts.ps1 $connectionString $preDeployScriptsXml "Pre" $deployer $backupNeeded
		}
		elseif ($backupNeeded)
		{
			popd
			$deployer.logger.log("No Pre scipts will be run; backup only", "debug")
			.\TFSDeployerScripts\Invoke-SqlDeploymentScripts.ps1 $connectionString $null "Pre" $deployer $backupNeeded
		}
		else
		{
			$deployer.logger.log("No Pre scipts or Backup will be run", "Warning")
		}
		
		pushd "$($deployer.Config.Deployment.Path2SqlCompareDir)"
		
		#going to do double sync, where first sync is w/o any constrants set 
		# and the set is with the constrants 
		#REASON this way be can better protect ourselves from tigger and RI 
		#sync errors 
		foreach ($sync in $($sqlCompareArgsPath_noCon, $sqlCompareArgsPath))
		{
			$results = .\sqlcompare.exe /argfile:"$($sync)"
			
			[int] $sqlExitCode = $lastExitCode
			
			$results | Out-File -FilePath $outputResults -Force -Append

			if ($sqlExitCode -eq 63) 
			{
				$deployer.Message.AppendLine("<b>WARNING: Database Sync returned identical databases</b>")
			}
			elseif ($sqlExitCode -ne 0)
			{
				$deployer.Logger.Log("SQL Compare Pro failure`nExitcode: $lastExitCode`nResults:`n$($results)", "error")
				[string] $errMsg = get-ErrorMsg $sqlExitCode
				throw "Error: $errMsg" 
			}
			else
			{
				$deployer.Logger.Log("successful Database sync", "config")
				
			}
		}
		
		pushd $($deployer.config.deployment.CommonScriptsLocation)
		
		$deployer.Message.AppendLine($("<b>SQL Compare results:</b> " + $syncLogs))
		
		#post deployment scripts 
		
		[System.IO.FileInfo] $postDeployScriptsXml = $(Get-Item $(Join-Path $scriptsPath "Post-Deployment\PostDeployment.xml"))
		
		if ($postDeployScriptsXml.Exists)
		{
			.\TFSDeployerScripts\Invoke-SqlDeploymentScripts.ps1 $connectionString $postDeployScriptsXml "Post" $deployer
		}
		
		
		$deployer.Logger.Log("Removing Scripts folder: $wsFolder", "debug")

		Remove-Item -Path $wsFolder -Recurse -Force

	}
	else
	{
		continue
	}
}

if ($syncCount -eq 0)
{
	$deployer.Message.AppendLine("<b>WARNING:</b> No Database Sync found for this region")
}
