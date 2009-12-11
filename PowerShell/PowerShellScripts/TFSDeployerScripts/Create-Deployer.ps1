param([xml] $deploymentMap = $(throw 'Deployment Mapping Xml is reguired'),
	  [xml] $config = $(throw 'Deployer Config xml is required'),
      $buildData = $(throw 'The TFS Deployer BuildData is required'), 
	  [string] $originalQuality = $(throw 'The Original Build Quality is Required'),
	  [string] $path2Deploy = $(throw 'The path to the kick off script is required'))


function create-PackageTypesObj ([xml] $dc)
{
	$ptype = new-object object 
	
	if ($dc.settings.Packages)
	{
		foreach ($package in $dc.settings.Packages.Package)
		{
			if ($package.GetAttribute("Deploy") -eq "true")
			{
				[string] $_type = $package.GetAttribute("DeploymentType")
				
				$ptype | Add-Member -MemberType NoteProperty -Name $_type -Value ($true -as [bool]) 
			}
		}
	}
	else
	{
		$ptype | Add-Member -MemberType NoteProperty -Name "DBSync" -Value ($true -as [bool])
	}
	
	return $ptype
}

function create-AddInObj ([string] $name)
{
	$obj = new-object Object
	
	$obj | Add-Member -MemberType NoteProperty -Name "Name" -Value $name
	
	$obj | Add-Member -MemberType NoteProperty -Name "Run" -Value $false
	
	return $obj

}

function get-Logger ($_d)
{
	pushd ($_d.Config.Deployment.CommonScriptsLocation)
	
	$logger = .\Create-Logger.ps1 ($_d.Config.Deployment.Logging.EventSource) ($_d.Config.Deployment.Logging.ID) ($_d.Config.Deployment.Logging.Level)

	popd
	
	return $logger
	 
}

function create-MailObj ($_d)
{
	$mail = New-Object Object
	
	$mail | Add-Member -MemberType NoteProperty -Name "Recipient" -Value $_d.EmailRecipient
	$mail | Add-Member -MemberType NoteProperty -Name "Subject" -Value "" 
	$mail | Add-Member -MemberType NoteProperty -Name "Body" -Value "" 
	$mail | Add-Member -MemberType NoteProperty -Name "CommonScriptsLocation" -Value $_d.Config.Deployment.CommonScriptsLocation
	
	$mail | Add-Member -MemberType ScriptMethod -Name "Send" -Value {Push-Location $this.CommonScriptsLocation
.\Send-Email $this.Recipient $this.Subject $this.Body
Pop-location}

	return $mail
}

function check-AddinScripts ($path, $dr)
{
	#after adding new addin scripts need to update the TFSDeployerConfigMapping.xsd to allow 
	#the new addin script to be a part of the config xml
	
	[hashtable] $addin = @{"BeforeStart" = $(create-AddinObj "BeforeStart") ;
							"AfterEnd" = $(create-AddinObj "AfterEnd") ;
							"BeforePush" = $(create-AddinObj "BeforePush");
							"OverridePush" = $(create-AddinObj "OverridePush");
							"AfterPush" = $(create-AddinObj "AfterPush") ;
							"BeforeWorkItemUpdate" = $(create-AddinObj "BeforeWorkItemUpdate");
							"OverrideWorkItemUpdate" = $(create-AddinObj "OverrideWorkItemUpdate");
							"AfterWorkItemUpdate" = $(create-AddinObj "AfterWorkItemUpdate");
							"BeforeDeploymentDBUpdate" = $(create-AddinObj "BeforeDeploymentDBUpdate");
							"OverrideDeploymentDBUpdate" = $(create-AddinObj "OverrideDeploymentDBUpdate");
							"AfterDeploymentDBUpdate" = $(create-AddinObj "AfterDeploymentDBUpdate");
							"BeforeBuildQualityUpdate" = $(create-AddinObj "BeforeBuildQualityUpdate");
							"OverrideBuildQualityUpdate" = $(create-AddinObj "OverrideBuildQualityUpdate");
							"AfterBuildQualityUpdate" = $(create-AddinObj "AfterBuildQualityUpdate");
							"OverrideDeploymentConfig" = $(create-AddinObj "OverrideDeploymentConfig");
							"BeforeSyncDB" = $(create-AddinObj "BeforeSyncDB");
							"AfterSyncDB" = $(create-AddinObj "AfterSyncDB");
							"AfterGetDBScriptsFolder" = $(create-AddinObj "AfterGetDBScriptsFolder")}	
							
	if($deploymentMap.Settings.AddinScripts)
	{
		write-debug "In AddInSCripts Node"
		
		foreach ($script in $deploymentMap.Settings.AddinScripts.Script)
		{
			[string] $action = $script.GetAttribute("ActionType")
			[string] $scriptPath =  $(Join-Path $path $($script.GetAttribute("ScriptName")))
			
			write-debug "In AddInSCripts Node: $action => $scriptPath"
			
			if ($addin.ContainsKey($action) -and (Test-Path $scriptPath))
			{
				$addin[$action] | Add-Member -MemberType NoteProperty -Name "Script" -Value $scriptPath
				
				$addin[$action] | Add-Member -MemberType NoteProperty -Name "Deployer" -Value $dr
				
				$addin[$action].Run = $true -as [bool]
				
				$addin[$action] | Add-Member -MemberType NoteProperty -Name "ContinueOnError" -Value $($script.GetAttribute("ContinueOnError") -as [bool])
				
				$Addin[$action] | Add-Member -MemberType ScriptMethod -Name "Exec" -Value  {[bool] $success = $true
		
		if (Test-path $this.script)
		{
			push-location (split-path $this.script -parent)
			$success = & $this.script $this.Deployer
			pop-location 
		}
		else
		{
			$success = $false
		}
		
		if ($this.ContineOnError -or $success)
		{
			return $true
		}
		else
		{
			throw ("ERROR: " + $($this.script) + " unsuccessfully ran")
		}
	} #end exec scriptblock	
	
		 
			} #end if ($addin.ContainsKey($action...
		} #end foreach )$scripts 
	}
	
	return $addin
	
}

function create-DeploymentNoteObj ($dc, [string] $env, [string] $tp, [string] $bn, [string] $deployType)
{
	$dnote = new-object Object
	
	$dnote | Add-Member -MemberType NoteProperty -Name "Note" -Value ""
	
	[scriptblock] $getDeploymentNote  = {
	$dm = $args[0]
	[string] $_env = $args[1]
	[string] $_tp = $args[2]
	[string] $_bn = $args[3]
	[string] $_deployType = $args[4]
	
	[string] $note = ""
	
	if ($dm.Settings.Packages -and 
		$_deployType -ne "DBOnly")
	{
		foreach ($p in $dm.Settings.Packages.Package)
		{
			if ($($p.GetAttribute("Deploy")) -ne "true")
			{
				continue
			}
			
			if ($_deployType -eq "ConfigsOnly")
			{
				$note += "<p>The Package configs for `"" + $p.GetAttribute("PackageName") + "`" were deployed to:<br>"
			}
			else
			{
				$note += "<p>The Package Named `"" + $p.GetAttribute("PackageName") + "`" was deployed to:<br>"
			}
			
			if ($_env -eq "IRB")
			{
				$note += "* $/" + $_tp + "/Release/" + $_bn + "/" + $p.GetAttribute("PackageName")
			}
			elseif($p.DeploymentRegions)
			{
				foreach($loc in $p.DeploymentRegions.SelectSingleNode("DeploymentRegion[@Name='$_env']").RegionLocations.Location)
				{
					$note += "* " + $loc.Path + "<br>"
				}
			}
			else
			{
				$note += " <b>$_env</b>"
			}
			
			$note += "</p>"
		}
	}
	
	if ($dm.Settings.Databases -and 
		(($_deployType -eq "Full" -and 
		 $_env -ne "IRB") -or 
		$_deployType -eq "DBOnly"))
	{
		$note += "<p>Database Scripts Folder(s) used:<br>"
		
		[int] $i = 0
		
		foreach($db in $dm.Settings.Databases.Database)
		{
			if ($($db.GetAttribute("Sync")) -ne "true" -or 
			    $($db.GetAttribute("Region")) -ne $_env)
			{
				continue
			}
			
			$i++
			$note += "* Script Folder at " + $($db.GetAttribute("TFVCServerPath"))  + " labeled `"$bn`" was used during a sync<br>"
		}
		
		if ($i -eq 0)
		{
			$note += "<b>Warning:</b>No Database sync for this region<br>"
		}

		$note += "</p>"
	}
	
	$note += "<br><b>Additional Information:</b><br>"
	
	$this.note =  $note
} #end script block

	$dnote | Add-Member -MemberType ScriptMethod -Name "Update" -Value $getDeploymentNote
	
	$dnote.Update($dc, $env, $tp, $bn, $deployType)
	
	return $dnote
}

function create-RegionNameObj($envXml)
{
	$reg = new-object Object 
	
	if ($envXml -ne $null)
	{
		$reg | Add-Member -MemberType NoteProperty -Name "FullName" -Value ($envXml.GetAttribute("FullName"))
		
		$reg | Add-Member -MemberType NoteProperty -Name "Name" -Value ($envXml.GetAttribute("Name"))
		
		$reg | Add-Member -MemberType NoteProperty -Name "ShortName" -Value ($envXml.GetAttribute("ShortName"))
	}
	
	return $reg
	
}

function create-MessageObj ()
{
	$msg = new-object Object 
	$sb = new-object System.Text.StringBuilder
	
	$msg | Add-Member -MemberType NoteProperty -Name "Msg" -Value $sb
	
	$msg | Add-Member -MemberType ScriptMethod -Name "Append" -Value {$this.Msg.Appendformat("{0}", $($args[0] -as [string])) | out-null}
	
	$msg | Add-Member -MemberType ScriptMethod -Name "AppendLine" -Value {$this.Msg.Appendformat("{0}<br>", $($args[0] -as [string])) | out-null}
	
	$msg | Add-Member -MemberType ScriptMethod -Name "ToHtml" -Value {"<Div>" + $this.Msg.Tostring() + "</Div>"}
	
	return $msg
	
}

function get-UserEmail ([string] $id, [string] $baseUrl)
{
	[string] $address = $($id + $baseUrl)
	
	$ds = new-object DirectoryServices.DirectorySearcher
	$ds.Filter="(&(objectategory=person)(objectclass=user)(sAMAccountname=$id))"
	$user = $ds.findOne()
	
	if ($user.path.length -gt 1)
	{
		$address = $user.Properties.mail
	}
	
	return $address
}

function new-LogDirectory ([string]$_path2Hpp, [string] $_tp, [string] $_tbt, [string] $_bn, [string] $_env)
{
	[string] $dateStamp = $(Get-Date).ToString("yyyy") + "\"
	$dateStamp += $(Get-Date).ToString("MMMM") + "\"
	$dateStamp += $(Get-Date).ToString("MMdd")
	
	$logFolder = Join-Path $_path2Hpp "Logs\$dateStamp\$_env\$_tp\$_tbt\$_bn"
	
	if (-not (Test-Path $logFolder))
	{
		return (new-item -Path $(Split-Path $logFolder -Parent) -Name $(Split-Path $logFolder -Leaf) -ItemType Directory)
	}
	else
	{
		return (Get-Item $logFolder)
	}
}

###MAIN###
[string] $string = ""

$_deployer = New-Object Object

$_deployer | Add-Member -MemberType NoteProperty -Name "DeploymentConfig" -Value $deploymentMap

$_deployer | Add-Member -MemberType NoteProperty -Name "Config" -Value $config

$_deployer | Add-Member -MemberType NoteProperty -Name "Message" -Value $(create-MessageObj)

$_deployer | Add-Member -MemberType NoteProperty -Name "Log" -Value $string

$_deployer | Add-Member -MemberType NoteProperty -Name "Error" -Value $string

$_deployer | Add-Member -MemberType NoteProperty -Name "ErrorMessage" -Value $string

$_deployer | Add-Member -MemberType NoteProperty -Name "BuildData" -Value $BuildData

$_deployer | Add-Member -MemberType NoteProperty -Name "OriginalBuildQuality" -Value $originalQuality

$_deployer | Add-Member -MemberType NoteProperty -Name "Env" -Value $($config.Deployment.BuildQualityConversions.SelectSingleNode("BuildConversion[@Original='$($BuildData.BuildQuality)']").GetAttribute("Converted"))

$_deployer | Add-Member -MemberType NoteProperty -Name "RegionName" -Value (create-RegionNameObj $_deployer.Config.Deployment.Environments.SelectSingleNode("Environment[@FullName='$($_deployer.Env)']"))

$_deployer | Add-Member -MemberType NoteProperty -Name "DeploymentType" -Value $(if ($_deployer.BuildData.BuildQuality.StartsWith("Deploy2")){"Full"}elseif ($_deployer.BuildData.BuildQuality.StartsWith("Sync")){"DBOnly"}else{"ConfigsOnly"})

$_deployer | Add-Member -MemberType NoteProperty -Name "DeploymentNote" -Value $(create-DeploymentNoteObj $_deployer.DeploymentConfig $_deployer.RegionName.Name $_deployer.BuildData.TeamProject $_deployer.BuildData.BuildNumber $_deployer.DeploymentType)

$_deployer | Add-Member -MemberType ScriptMethod -Name "UpdateDeploymentNote" -Value {$this.DeploymentNote.Update($this.DeploymentConfig, $this.RegionName.Name, $this.BuildData.TeamProject, $this.BuildData.BuildNumber, $this.DeploymentType)}

$_deployer | Add-Member -MemberType NoteProperty -Name "BuildDataDetails" -Value $($BuildData | get-member | where {$_.Membertype -eq "Property"} | foreach {write-output $("<b>" + $_.Name + "</b> => " + $TFSDeployerBuildData.$($_.Name) + "<br>")})

$_deployer | Add-Member -MemberType NoteProperty -Name "Path2Deploy" -Value $path2Deploy

$_deployer | Add-Member -MemberType ScriptProperty -Name "TFSDeployerScriptDirectory" -Value {Split-Path $this.path2Deploy -parent}

$_deployer | Add-Member -MemberType NoteProperty -Name "TFS" -Value $(..\Get-TFS.ps1)

$_deployer | Add-Member -MemberType NoteProperty -Name "HppTools" -Value $(..\Load-Tools.ps1)

$_deployer | Add-Member -MemberType NoteProperty -Name "LogDir" -Value $(New-LogDirectory $config.Deployment.LogLocation $buildData.Teamproject $buildData.BuildType $buildData.BuildNumber $_deployer.RegionName.Name)

$_deployer | Add-Member -MemberType NoteProperty -Name "SQLDeployer" -Value $(.\Get-SQLDeployer.ps1 $_deployer)

write-debug  "Running Add"

[hashtable] $add = check-AddinScripts $(Split-Path $path2Deploy -parent) $_deployer

$_deployer | Add-Member -MemberType NoteProperty -Name "AddinScripts" -Value $add

write-debug  "Add scripts completed"

[string] $user= $($BuildData.LastChangedBy.split('\'))[1]

if ($originalQuality -eq "Unexamined" -and
    ($buildData.BuildQuality -eq "Deploy2-Assembly" -or 
     $buildData.BuildQuality -eq "Deploy2-Test" -or
     $buildData.BuildQuality -eq "Deploy2-Dev"))
{
	$user = $($BuildData.RequestedBy.split('\'))[1]
}

$rec = get-UserEmail $user $config.Deployment.CommonEmailAddress

Write-Debug "User Email set to $rec"

$_deployer | Add-Member -MemberType NoteProperty -Name "EmailRecipient" -Value $rec

$_deployer | Add-Member -MemberType NoteProperty -Name "Mailer" -Value (create-MailObj $_deployer)

$_deployer | Add-Member -MemberType NoteProperty -Name "Logger" -Value (get-Logger $_deployer)

$_deployer | Add-Member -MemberType NoteProperty -Name "PackageTypes" -Value (create-PackageTypesObj $_deployer.DeploymentConfig)

#checking to see if TFS config info is there if verify that it is correct

if ($_deployer.DeploymentConfig.Settings.TFS)
{
	if (!($($_deployer.BuildData.TeamProject) -eq $($_deployer.DeploymentConfig.Settings.TFS.TeamProject)) -or
	    !($($_deployer.BuildData.BuildType) -eq $($_deployer.DeploymentConfig.Settings.TFS.TeamBuildType)))
	{
		#this ensures that correct deploymentConfig.xml is being called, this fills a gap in the 
		#TFS Deployer architure, b/c all deployment files are downloaded to same folder
		#therefore a deployer could get the wrong deploymentconfig 
		
		[string] $errmsg = "DeploymentConfig mapping and build data do not match, deployment aborted. Please ensure TFS node in the DeploymentConfig.xml is correct"
		
		$_deployer.logger.log($errmsg, "error") 
		
		throw ($errmsg)
	}
	else
	{
		$_deployer.logger.log("Deployment config and build data match", "config") 
	}
}
else
{
	$_deployer.logger.log("No TFS DeploymentConfig entry found", "config") 
}

write-debug "Return Deployer Obj"

return $_deployer