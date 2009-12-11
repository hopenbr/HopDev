#Sync-TFVC2Share
#This script will download a dir from TFVC
#once downloaded we will sync a share to TFVC 
#Now that workspace is update we'll call TFPT.exe online to update the
#workspace and check in the updated (diff, deletes, and adds) 
#this will sync the entire workspace mappings, regradless of what WSpath 
#is passed in (as long as the path is somewhere in the workspace)
#
param([string] $sharePath = $(throw 'The Full UNC path to the share is requied'),
	  [string] $wsPath = $(throw 'The local path to the workspace is requied'),
	  [string] $serverPath = $(throw 'The TFVC server path is required'),
	  [string] $logPath = $($null),
	  [bool] $silent = $($false),
	  # sync args need to separated by a space
	  [string] $syncArgs = $($null))

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 


###MAIN###
$dtStamp = $(Get-Date).ToString("yyyyMMddhhmmss")

pushd $(Split-Path $(get-Script) -Parent)

if($logPath -eq $null)
{
	$logPath = $(Join-Path "C:\" $("SyncLog_" + $dtStamp + ".log"))
}

$logger = .\Create-Logger.ps1 "TFVC2ShareSyncer" "1200" "Debug" "File" $logPath
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

$logger.Log($($ws.Get()| out-string), "info")

if(Test-path $sharePath)
{
	$logger.log("Calling Sync-Directories.ps1", "info")
	$s = .\Sync-Directories.ps1 $sharePath $wsPath $($logger.LogFile) $true $syncArgs
}
else
{
	[string] $emsg = "Error: Invalid Share; Cannot find share location $sharePath"
	$logger.Log($emsg, "Error")
	throw $emsg
}


$tools = .\Load-Tools.ps1 

cd $wsPath
#PWD needs to be w/in local workspace for TFPT online to work 

$logger.log("Calling TFPT.exe online /adds /diff /deletes /recursive /noprompt", "info")

$results = & $tools.TFPT online /adds /diff /deletes /recursive /noprompt  2>&1

$logger.Log($results, "info")

Pop-Location

New-Variable -Name compMsg -value "Sync Job complete,"
New-Variable -Name cs -Value $null

if ( $ws.GetPendingChanges().Count -gt 0)
{
	$cs = $ws.CheckIn($ws.GetPendingChanges(), "Sync from $sharePath")

	$logger.Log("Sync Finished Changeset $cs", "info")
	
	$compMsg += " Changeset: $cs;"
	
}
else
{
	$logger.Log("Sync Finished No changes detected", "info")
	$compMsg += " no updates found;"
}

if (-not $silent)
{
	Write-host "$compMsg; check logfile for more information $($logger.LogFile)" 
}

return $cs