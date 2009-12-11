Param([string] $deployScriptPath = $(throw 'The Path the kick off deploy script is required'))

trap 
{ 
    $script = get-script
	$script_folder = split-path $script
	Push-Location $script_folder
	$ex = $_
    $msgLog = "Trapped error and sending email`n`nException Stack:`n" + $($ex | gm -type property | %{$ex.($_.Name) | out-string}) + "`nLast Error encountered:`n" + $($Error[$Error.Count -1])
	[string] $msgLevel = "Warning"
	[string] $msgId = "4201"
	
	if ($majorError)
	{
		$msgLevel = "Error"
		$msgId = "4202"
		..\Update-BuildQuality.ps1 $("/BuildUri=" + $($TFSDeployerBuildData.BuildUri)) "In-Error" $TfsDeployerBuildData.TeamProject $TfsDeployerBuildData.BuildType
	}
	
	..\Write-EventLog.ps1 $msgLog "Harleysvill.TfsDeployer" $msgId $msgLevel
	
	send-error $_
	break 
}   
function send-error ($ex)                                                                                             
{ 
	$subject = "TFS Deployer Error: " + $ex.CategoryInfo.Reason
	                                             
	[string] $b = $("<p>Deployment Error Type: " + $ex.CategoryInfo.Reason + "</p>")
	$b += $("<p><u>Exception:</u><br>")
	$b += $($ex | gm -type property | %{$prop = ($ex.($_.Name) | out-string) + "<br>"; $prop })
	$b += $("</p><br>")
	$b += $deployer.Message.ToHtml()
	
	$rec = $($TfsDeployerBuildData.LastChangedBy.split('\'))[1] + "@HarleysvilleGroup.com"
	
	if ($TFSDeployerOriginalQuality -eq "Unexamined" -or $rec -match "tfsbuild")
	{
		$rec = $($TfsDeployerBuildData.RequestedBy.split('\'))[1] + "@HarleysvilleGroup.com"
	}
	
	if (!$majorError)
	{
		$subject = $TFSDeployerBuildData.BuildNumber + " Successfully Deployed w/ warning(s)"
		
		$b = $("<p>There was an error after the build package was SUCCESSFULLY deployed<br>" + $deployer.DeploymentNote.Note + "<br>Please contact the <a href=`"mailto:SRM@harleysvilleGroup.com`">SRM team</a> to alert them of the warning</p><br>" + $b)
	}
	
	[int] $eventCount = 50 
	[string] $body += $(Get-EventLog application -new $eventCount | select EventID,EntryType,TimeGenerated,Source,Message | convertto-html -body $("$b<br><h3>App Event Log ($env:Computername) as of $(Get-date)</h3><br><p>Latest $eventCount entries:</p><br>"))
	               
	..\Send-Email.ps1 $rec $subject $body | out-null
}  

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

function write-InfoLog ([string] $_msg)
{
    .\Write-EventLog.ps1 $_msg $deployer.config.Deployment.EventSource "4200"
}

function write-InfoLog ([string] $_msg, [string] $_eventNum)
{
    .\Write-EventLog.ps1 $_msg $deployer.config.Deployment.EventSource $_eventNum
}


function get-eventlogErrorNumber ([string] $_env)
{
	if ($_env.contains("Production"))
	{
		return "4212"
	}
	else
	{
		return "4202"
	}	
}

function get-DeploymentConfig ([string] $dcPath)
{
	[xml] $x = $(gc $dcPath) -replace "xmlns=`"[\w\W]+?`"", ""
	return $x
}

function check-LastChangedTime ([datetime] $lastchanged, [int] $min)
{
	#this fucntion checks to ensure that a datetime object is within the 
	#last $min about of minutes therefore $min shall always be a neg number
	
	if ($min -gt 0)
	{
		$min = -$min
	}
	
	if ($lastChanged -gt $(get-date).AddMinutes($min))
	{
		return $true
	}
	else
	{
		return $false
	}
	
}


###MAIN###

#this error will be used during the trap if there is a major error one 
#before push the BQ will be put in "In-Error"
[bool] $majorError = $true

#Getting location of script running and then cd to it
$script = get-script
$script_folder = split-path $script
Push-Location $script_folder

$_configXml = [xml] $(get-content .\Config.xml)
[bool] $_inDebug = $false

if($_configXml.Deployment.Logging.Level -eq "debug" -or
   $_configXml.Deployment.Logging.Level -eq "config")
{
	$_inDebug = $true
} 

if ($_inDebug)
{
	..\Write-EventLog.ps1 "TFSDeployer Pre-Start" "HIC.TFSDeployer" "42000"
}

if (!$(check-LastChangedTime $tfsdeployerBuildData.LastChangedOn -6))
{
	[string] $msg = "Timestamp: $(Get-Date)`n" +
			"Build: $($TFSDeployerBuildData.BuildNumber)`n" +
			"LastChangedOn: $($TFSDeployerBuildData.LastChangedOn)`n" + 
			"Message: Deployment is not within the allowed margin of time; " +
			"LastChangedOn time stamp cannot be older than 6 minutes";
			
	..\Write-EventLog.ps1 $msg "HIC.TFSDeployer" "42003" "warning"
	return $false 
}

#getting full path to DeploymentConfig.xml
$path2DeploymentConfig = (Join-Path (split-path $deployScriptPath -parent) "DeploymentConfig.xml")

if ($_inDebug)
{
	..\Write-EventLog.ps1 "TFSDeployer Calling Validate Xml" "HIC.TFSDeployer" "42000"
}

#checking to see if xml is validate
[bool] $isValid = $false

if ($(gc $path2DeploymentConfig) -match "http://as73tfsbuild01/TFSDeployerConfigMapping.xsd")
{
	#the config is using version 1 of XSD with old Namespace 
	$isValid = ..\Validate-Xml $path2DeploymentConfig "http://as73tfsbuild01/TFSDeployerConfigMapping.xsd" "http://as73tfsbuild01/TFSDeployerConfigMapping.xsd"
}
else
{
	#Schema version Next
	#new namespace "urn:schema-Harleysvillegroup-com:TFSDeployerConfig"
	$isValid = ..\Validate-Xml $path2DeploymentConfig $_configXml.Deployment.DeploymentConfigSchemaName $(Invoke-Expression $_configXml.Deployment.DeploymentConfigSchemaUri)
}

#this is a work around, where I rip out the xsd namespace b/c it causes the XPath calls not to work 
[xml] $packageMappings = get-DeploymentConfig $path2DeploymentConfig

if ($_inDebug)
{
	..\Write-EventLog.ps1 "TFSDeployer Calling Create-Deployer" "HIC.TFSDeployer" "42000"
}

$deployer = .\Create-Deployer $packageMappings $_configXml $TfsDeployerBuildData $TFSDeployerOriginalQuality $deployScriptPath

$deployer.Logger.log("TFSDeployer Check XML", "HIC.TFSDeployer", "config", "42000")
#Checking validatiam after $deployer creation b/c this will allow the trap hanlder to work correctly
if(!$isValid)
{
	throw("Error: DeploymentConfig.xml not valid, $($Error[$Error.Count - 1])")
	return $false
}

$deployer.Logger.log("TFSDeployer Pre-Start Complete", "HIC.TFSDeployer", "config", "42000")

Pop-location


#push to common scripts 
Push-Location $deployer.config.Deployment.CommonScriptsLocation


#check what type of deployment is requested
if ($deployer.env.Equals("RollBack"))
{
	$deployer.logger.log("Starting rollback", "Info")
	
	#$rollBackEnv = $($TFSDeployerOriginalQuality.split('-'))[1]
	
	#write-InfoLog $("Starting roll Back of " + $rollBackEnv + "`n`nBuildData:`n" + $deployer.BuildDataDetails) "42001"
	
	$deployer.logger.log("#*#*#*# CALLING: Prepare4-Rollback", "debug")
	.\TFSDeployerScripts\Prepare4-Rollback  $deployer
	
	.\TFSDeployerScripts\Update-WorkItem.ps1 $deployer
	
	$deployer.logger.log("Exiting deployer RollBack in progress", "info")
	
	return "Exit"
	
}
elseif ($deployer.env.Equals("ConfigUpdate"))
{
	$deployer.logger.log($("Starting Env.Config folder update of build package: " + $deployer.BuildData.BuildNumber), "Info", "42001")
	
	$deployer.Mailer.Subject =  "Build $($Deployer.BuildData.BuildNumber) Configuration files update started" 
	$deployer.Mailer.Body = "$($deployer.BuildData.BuildNumber) Configuration files will be updated shortly.<br><br>BuildInfo:<br><p>$($deployer.BuildDataDetails)</p>"
	$deployer.Mailer.Send() | out-null
	
	$deployer.logger.log("#*#*#*# CALLING: Update-EnvCOnfig", "Debug")
	.\TFSDeployerScripts\Update-EnvConfig.ps1 $deployer
	
	$deployer.logger.log("#*#*#*# CALLING: Update-BQ", "debug")
	.\Update-BuildQuality.ps1 $("/BuildUri=" + $($deployer.BuildData.BuildUri)) $deployer.OriginalBuildQuality $deployer.BuildData.TeamProject $deployer.BuildData.BuildType
	
	.\TFSDeployerScripts\Update-WorkItem.ps1 $deployer
	
	$deployer.logger.log("Config update Complete", "Config") 
	
	$deployer.Mailer.Subject = "Configs have been updated Succesfully for " + $deployer.BuildData.BuildNumber
	$deployer.Mailer.Body = "All configs for all regions have been updated in the build store"
	$deployer.Mailer.Send() | out-null
	
	return "Exit"
	
}
else
{

	$eventLogErrorNumber = get-eventlogErrorNumber $deployer.env

	$deployer.logger.log($("Starting TFS Deployer`nBuildInfo:`n" + $deployer.BuildDataDetails + "`n ENV => " + $deployer.env), "info", "42001")
	
	if ($deployer.AddinScripts["OverrideDeploymentConfig"].Run)
	{
		$deployer.logger.log("CallIng AddIn OverrideDeploymentConfig", "debug")
		
		$deployer.AddinScripts["OverrideDeploymentConfig"].Exec() | out-null
		
		[bool] $isValid = .\Validate-Xml $path2DeploymentConfig "http://as73tfsbuild01/TFSDeployerConfigMapping.xsd" "http://as73tfsbuild01/TFSDeployerConfigMapping.xsd"
		
		if ($isValid)
		{	
			$deployer.DeploymentConfig = get-DeploymentConfig $path2DeploymentConfig
		
			$deployer.UpdateDeploymentNote()
		}
		else
		{
			throw "ERROR: Invalid Override Config passed in;"
		}
	
	}
	
	#check of addin script
	#if found run the script
	if ($deployer.AddinScripts["BeforeStart"].Run)
	{
		$deployer.logger.log("CallIng AddIn BeforeStart", "debug")
		
		$deployer.AddinScripts["BeforeStart"].Exec() | out-null
	}
	
	$deployer.Mailer.Subject =   $deployer.BuildData.BuildNumber + " Deployment to " + $deployer.RegionName.Name + " started"
	$deployer.Mailer.Body = "$($deployer.Mailer.Subject)<br><br>BuildInfo:<br><p>$($deployer.BuildDataDetails)</p>"
	$deployer.Mailer.Send() | out-null
	
	if ($deployer.AddinScripts["AfterStart"].Run)
	{
		$deployer.logger.log("CallIng AddIn AfterStart", "debug")
		
		$deployer.AddinScripts["AfterStart"].Exec() | out-null
	}
	
	if ($deployer.DeploymentConfig.Settings.Packages -and 
		$deployer.DeploymentType -ne "DBOnly")
	{
		
		if ($deployer.AddinScripts["BeforePush"].Run)
		{
			$deployer.logger.log("CallIng AddIn BeforePush", "debug")
			
			$deployer.AddinScripts["BeforePush"].Exec() | out-null
		}
		
		if ($deployer.AddinScripts["OverridePush"].Run)
		{
			$deployer.logger.log("CallIng AddIn PushOverride", "debug")
			
			$deployer.AddinScripts["OverridePush"].Exec() | out-null
		}
		else
		{
			if ($deployer.BuildData.BuildQuality.StartsWith("Configs2"))
			{
				$deployer.logger.log("#*#*#*# CALLING: Config update", "debug")
				.\TFSDeployerScripts\Update-EnvConfig.ps1 $deployer
				
				$deployer.Message.AppendLine("Build package Configs in Region " + $deployer.RegionName.Name + " were updated to match latest configs in TFVC before deployment")
			}
			
			$deployer.logger.log("#*#*#*# CALLING: Push-Packages", "debug")
			.\TFSDeployerScripts\Push-Packages.ps1 $deployer
		}
		
		if ($deployer.AddinScripts["AfterPush"].Run)
		{
			$deployer.logger.log("CallIng AddIn AfterPush", "debug")
			
			$deployer.AddinScripts["AfterPush"].Exec() | out-null
		}
	}
	
	if ($deployer.DeploymentConfig.Settings.Databases -and 
	    ($deployer.DeploymentType -eq "Full" -or 
	     $deployer.DeploymentType -eq "DBOnly"))
	{
		if ($deployer.AddinScripts["BeforeSyncDB"].Run)
		{
			$deployer.logger.log("CallIng AddIn BeforeSyncDB", "debug")
		
			$deployer.AddinScripts["BeforeSyncDB"].Exec() | out-null
		}
		
		.\TfsDeployerScripts\Sync-Database.ps1 $deployer
		
		if ($deployer.AddinScripts["AfterSyncDB"].Run)
		{
			$deployer.logger.log("CallIng AddIn AfterSyncDB", "debug")
		
			$deployer.AddinScripts["AfterSyncDB"].Exec() | out-null
		}
	}
	 
	$builds = "/BuildUri=" + $TfsDeployerBuildData.BuildUri

	if ($deployer.env.Equals("In-Systemtest01"))
	{
		 $deployer.env = "In-Conversion"
	}

	$newBQ = $deployer.env 

	if ($TFSDeployerOriginalQuality.Contains("Production"))
	{
		$newBQ = "In-Production"
	}
	
	if ($deployer.AddinScripts["BeforeBuildQualityUpdate"].Run)
	{
		$deployer.logger.log("CallIng AddIn BeforeBuildQualityUpdate", "debug")
		
		$deployer.AddinScripts["BeforeBuildQualityUpdate"].Exec() | out-null
	}
	
	if ($deployer.AddinScripts["OverrideBuildQualityUpdate"].Run)
	{
		$deployer.logger.log("CallIng AddIn BeforeBuildQualityUpdate", "debug")
		
		$deployer.AddinScripts["OverrideBuildQualityUpdate"].Exec() | out-null
	}
	else
	{
		$deployer.logger.log("#*#*#*# CALLING: Update-BQ", "debug")
		.\Update-BuildQuality.ps1 $builds $newBQ $TfsDeployerBuildData.TeamProject $TfsDeployerBuildData.BuildType
	}
	
	if ($deployer.AddinScripts["AfterBuildQualityUpdate"].Run)
	{
		$deployer.logger.log("CallIng AddIn AfterBuildQualityUpdate", "debug")
		
		$deployer.AddinScripts["AfterBuildQualityUpdate"].Exec() | out-null
	}
	
	$majorError = $false
	
	if ($deployer.AddinScripts["BeforeWorkItemUpdate"].Run)
	{
		$deployer.logger.log("CallIng AddIn BeforeWorkItemUpdate", "debug")
		
		$deployer.AddinScripts["BeforeWorkItemUpdate"].Exec() | out-null
	}
	
	if ($deployer.AddinScripts["OverrideWorkItemUpdate"].Run)
	{
		$deployer.logger.log("CallIng AddIn BeforeWorkItemUpdate", "debug")
		
		$deployer.AddinScripts["OverrideWorkItemUpdate"].Exec() | out-null
	}
	else
	{
		$deployer.logger.log("#*#*#*# CALLING: Update-WorkItem", "debug")
		.\TFSDeployerScripts\Update-WorkItem.ps1 $deployer
	}
	
	if ($deployer.AddinScripts["AfterWorkItemUpdate"].Run)
	{
		$deployer.logger.log("CallIng AddIn AfterWorkItemUpdate", "debug")
		
		$deployer.AddinScripts["AfterWorkItemUpdate"].Exec() | out-null
	}
	
	if ($deployer.AddinScripts["BeforeDeploymentDBUpdate"].Run)
	{
		$deployer.logger.log("CallIng AddIn BeforeDeploymentDBUpdate", "debug")
		
		$deployer.AddinScripts["BeforeDeploymentDBUpdate"].Exec() | out-null
	}
	
	if ($deployer.AddinScripts["OverrideDeploymentDBUpdate"].Run)
	{
		$deployer.logger.log("CallIng AddIn BeforeDeploymentDBUpdate", "debug")
		
		$deployer.AddinScripts["OverrideDeploymentDBUpdate"].Exec() | out-null
	}
	else
	{
		$deployer.logger.log("#*#*#*# CALLING: Update-EnvMap", "debug")
		[bool] $successful = .\TFSDeployerScripts\Update-EnvironmentMapping.ps1 $deployer
	}
	
	if ($deployer.AddinScripts["AfterDeploymentDBUpdate"].Run)
	{
		$deployer.logger.log("CallIng AddIn AfterDeploymentDBUpdate", "debug")
		
		$deployer.AddinScripts["AfterDeploymentDBUpdate"].Exec() | out-null
	}
	
	if ($deployer.AddinScripts["AfterEnd"].Run)
	{
		$deployer.logger.log("CallIng AddIn AfterEnd", "debug")
		
		$deployer.AddinScripts["AfterEnd"].Exec() | out-null
	}

	
	$deployer.Mailer.Subject =   $deployer.BuildData.BuildNumber + " Deployment to " + $deployer.RegionName.Name + " Complete"
	$deployer.Mailer.Body = $TfsDeployerBuildData.BuildNumber + " was successful deployed<br>" + $deployer.DeploymentNote.Note + "<br>$(if($deployer.Message.Msg.Length -gt 0){$deployer.Message.ToHtml()})"
	$deployer.Mailer.Send() | out-null
	

	$deployer.logger.log("End TFS Deployer", "info", "42002")
	
}

return $true