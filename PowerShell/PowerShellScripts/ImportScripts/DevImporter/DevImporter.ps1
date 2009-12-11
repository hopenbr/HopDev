#DevImoprter
#this script is used to import changes into TFVC from non-TFVC controlled area
#such as a development share 
#the Config file is a key component of this scripts since it drives the entire
#script 
#I hope to have an XSD soon for it 
#This script is dependent  on the HPP and has to be run a HPP server 
#
#The only changes that will not get picked up correctly are renames
#if an element is renamed (file or folder) it will be considered a new element
#and in the case of a rename folder all sub elements will also be added 
##
#in renaming is required than someone will have to go into TFVC to deleted the
#old named elements 



param([string] $path2Config = $(throw 'Error: No config passed in, a Config xml file is Required'),
      [bool] $debug = $($false)
)

trap 
{
	$msgLog = "Error trapped in $script`n`n$_"
	$logger.Log($msgLog, "Error")
	send-error $_ $_.Exception.GetType().Name
	break;
} 

function send-error                                                                                             
{ 
   if (!$debug)
   {
		Push-Location $config.Settings.CommonScriptsLocation
		$subject = "TFS DCT Importer Error: " + $Args[1].ToString()                                             
		$body =  "$Args[0]`n`nCheck Application Event log on " + $env:ComputerName + " for more information"                   
		.\Send-Email.ps1 $config.Settings.ErrorRecipient $subject $body	
	}
}

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 

function GetWorkSpace ([string] $_tfsUrl, $_shares, $_ws)
{
	$tfs = .\Get-TFS.ps1 $_tfsUrl
	[int] $count = 0
	
	if (!(Test-path $_ws.BaseDir))
	{
		new-item -type directory -name $(split-Path $_ws.BaseDir -leaf) -path $(split-Path $_ws.BaseDir -parent) | out-null
	} 
	
	$ws = .\Get-TfsWorkspace.ps1 $_ws.BaseDir $true $tfs 
	
	while (!$ws) 
	{	switch ($count)
		{
			0
			{
				$ws = .\Get-TfsWorkspace.ps1 $_ws.Name $true $tfs 
			}
			1
			{
				$ws = $tfs.vcs.CreateWorkspace($_ws.Name)	
			}
			2
			{
				throw "Error: Cannot create workspace"
			}
		}
		
		$count++
	}
	
	
	#ensure mapping is correct 
	
	foreach ($share in $_shares.share)
	{		
		$localMapping = $(Join-Path $_ws.BaseDir $share.Tfvc.SubFolder)
		$serverMapping = $(($share.Tfvc.ServerPath | out-string).TrimEnd())
		
		[bool] $b_isCorrectlyMapped = $false
		
		if ($ws.IsLocalPathMapped($localMapping) -and
		    $ws.IsServerPathMapped($serverMapping) -and
		    ($ws.GetServerItemForLocalItem($localMapping) -eq $serverMapping))
		{
			$b_isCorrectlyMapped = $true
		}
		    
		
		$share | out-string | write-debug
		$share.Tfvc | out-string | write-debug
		write-debug "local folder: $localMapping`nTFVC path: $serverMapping `n"
		
		
		if (!$b_isCorrectlyMapped)
		{
			$ws.Map($serverMapping, $localMapping) | out-null
		}
	}	
	
	$getResult = $ws.Get()
	Write-Debug $("Get Results:`n" + $($getResult))
	return $ws
}

#MAIN

if ($debug -and $DebugPreference -ne "Continue")
{
	$DebugPreference = "Continue"
}

$script = get-script
$script_folder = split-path $script
Push-Location $script_folder
#read in config info
$config = [xml] $(get-content $path2Config)
Pop-location
#push to common scripts 
Push-Location $config.Settings.CommonScriptsLocation
$logger = .\Create-Logger.ps1 $config.Settings.EventSource "4200" "Debug" "Event" 

[bool] $successful = $false

[bool] $b_debug = $false

if ($config.Settings.Debug -eq "true") {$b_debug = $true}

$workspace = GetWorkSpace $config.Settings.TFSUrl $config.Settings.Shares $config.Settings.Workspace

#sync logfile work
$logFileName = $config.Settings.EventSource + "_" + $(Get-Date).ToString("yyyyMMdd_hhmmss") + ".log"

New-Variable -Name lfd -Value ($Env:TEMP)
#if log path not given that it will be defaulted to temp directory 

if ($config.Settings.LogfileDirectory) 
{
	if (-not (Test-Path $config.Settings.LogfileDirectory))
	{
		$lfd = new-Item -path $(split-path $config.Settings.LogfileDirectory -Parent) -Name $(split-path $config.Settings.LogfileDirectory -leaf) -ItemType Directory
	}
	else
	{
		$lfd = $config.Settings.LogfileDirectory
	}
}

$lf = (Join-Path $lfd $logFileName)

$logger.log("Starting Importer`nSync Log file: ($lf)", "info")

[bool] $wereFilesImported = $false

foreach ($share in $config.Settings.Shares.Share)
{ 
	[string] $wsPath = $(Join-Path $config.Settings.Workspace.BaseDir $share.Tfvc.SubFolder)
	
	$changeset = .\Sync-TFVC2Share.ps1 $share.Target $wsPath $share.Tfvc.ServerPath $lf $true $($config.Settings.SyncSwitches)
	#sync-TFVC2Share returns ChangeSet number if files were updated in TFVC; 
		#it returns $null if no changes were detected
	
	if ($changeset -ne $null)
	{
		$wereFilesImported = $true
	}
	
}

$logger.log("Importer Complete`nSync Log file: $lf", "info")

return $wereFilesImported