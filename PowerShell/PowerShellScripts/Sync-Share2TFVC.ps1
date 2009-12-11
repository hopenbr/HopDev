#Sync-Share2TFVC
#This script will download a dir from TFVC
#once downloaded we will sync TFVC workspace to the Share
#
#

param([string] $sharePath = $(throw 'The Full UNC path to the share is requied'),
	  [string] $wsPath = $(throw 'The local path to the workspace is requied'),
	  [string] $serverPath = $(throw 'The TFVC server path is required'),
	  [string] $backupFolder = $("C:\"),
	  [bool] $backup = $($true),
	  [bool] $silent = $($false))

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 

###MAIN###
$dtStamp = $(Get-Date).ToString("yyyyMMddhhmmss")

pushd $(Split-Path $(get-Script) -Parent)

$logger = .\Create-Logger.ps1 "Share2TFVCSyncer" "1200" "Debug" "File" $(Join-Path $(Split-Path $wsPath -Parent) $("SyncLog_" + $dtStamp + ".log"))
#log file will be in parent directory of the workspace folder

New-Variable -Name ws -Scope script

if ((Test-Path $wsPath))
{
	$ws = .\Get-TfsWorkspace.ps1 $wsPath $false
	 #if no wrokspace is found TFSWorkspace script will fail b/c 
	 #continueOnError is set to $false 
	 
#	if ($ws -eq $null)
#	{
#		$ws = new-workspace $wsPath $serverPath
#	}
}
else
{
	#$ws = new-workspace $wsPath $serverPath
	[string] $emsg = "Create workspace is not implemented yet, please create workspace for sync job"
	$logger.OutputType = "Event"
	#need to log to event log b/c file is not validat b/c no local workspace was found 
	$logger.Log($emsg, "Error")
	throw $emsg
}

$logger.Log("Sync started, Share: $sharePath, serverPath: $serverPath, workspace: $wsPath", "Info")

if(Test-path $sharePath)
{
	if ($backup)
	{
		$tools = .\Load-Tools.ps1
		$logger.Log("Backing up Share: $sharePath", "Info")
		$results = (& $tools.zip a -t7z $(Join-Path $backupFolder $($(split-path $sharePath -leaf ) + "_" + $dtStamp + ".7z")) -mx1 $sharePath 2>&1)
		$logger.Log($results, "Info")
		
		if (-not ($results -match "Everything Is OK"))
		{
			$logger.Log("There was an error during backup", "Error")
			Throw "There was an error during backup, $results"
		}
		
	}
	
	$logger.Log($($ws.Get()| out-string), "info")

	$logger.log("Calling Sync-Directories.ps1", "info")
	$s = .\Sync-Directories.ps1 $wsPath $sharePath $($logger.LogFile)
	$logger.log("successful Sync: $s", "info")
}
else
{
	[string] $emsg = "Error: Invalid Share; Cannot find share location $sharePath"
	$logger.Log($emsg, "Error")
	throw $emsg
}

if (-not $silent)
{
	Write-Host "Sync complete check logfile for more information $($logger.LogFile)" 
}
