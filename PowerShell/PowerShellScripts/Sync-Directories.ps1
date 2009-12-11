#Sync-Directories
#Will Sync two folders up
#Synchronize ["Target"] to match ["Source"]. Only ["Target"] is modified.
#update(2009-04-13): Going to use Beyond compare 2 to do this sync job 
#update (2009-05-08): Going to switch to java based sync21 b/c is cmdline based


param([string] $sourcePath = $(throw 'The full UNC path to source directroy is required'),
	  [string] $targetPath = $(throw 'The full UNC path to target directroy is required'),
	  [string] $logFile = $("C:\HPP_SyncJob" + $(Get-Date).tostring("yyyyMMdd_mmhhss") + ".log"),
	  [bool] $silent = $($true),
	  #switch HAVE to be separated by a space
	  #defaulted to full sync 
	  [string] $syncSwitches = $("--force --ignorewarnings"))
	  
function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 

function check-SyncSwitches ([string] $ss)
{
	if ($ss.length -gt 2)
	{
		if (-not ($ss -match "ignorewarnings"))
		{
			$ss += " --ignorewarnings"
		}
		
		if (-not ($ss -match "force"))
		{
			#if force switch is not present need to make sure the 
			#all action points are set if they are not sync21 will 
			#promt for an answer which will hang the script 
			
			#all not present switch will be defaulted to no 
			
			if (-not ($ss -match "overwrite"))
			{
				$ss += " --overwrite:n"
			}
			
			if (-not ($ss -match "synctime"))
			{
				$ss += " --synctime:n"
			}
			
			if (-not ($ss -match "rename"))
			{
				$ss += " --rename:n"
			}
			
			if (-not ($ss -match "delete"))
			{
				$ss += " --delete:n"
			}
		}
	}
	else
	{ #if switches are blank use default switches which is a full sync job 
	  #to miror the target w/ source 
	  
		$ss = "--force --ignorewarnings"
	}
	
	if ($ss -match "force" -and
	    ($ss -match "delete:n" -or
		 $ss -match "synctime:n" -or 
		 $ss -match "overwrite:n" -or
		 $ss -match "rename:n"))
	{
		throw "Error: Invalid sync switches; cannot force a sync with other actions set to no"
	}
	
	return $ss
}

###MAIN###

$script = get-script
$script_folder = split-path $script
Push-Location $script_folder

$tools = .\Load-Tools.ps1

[System.IO.DirectoryInfo] $source = New-Object -TypeName System.IO.DirectoryInfo -ArgumentList $sourcePath
[System.IO.DirectoryInfo] $target = New-Object -TypeName System.IO.DirectoryInfo -ArgumentList $targetPath

$syncSwitches = check-SyncSwitches $syncSwitches

"Sync Switches were set to: $syncSwitches" | Out-File -FilePath $logFile -Append -Encoding ASCII

New-Variable -Name syncLog -Value ""

if ($logFile -eq "host")
{
	java -jar $($tools.Sync.FullName) $syncSwitches.split(" ") $source.fullName $target.FullName

}
else
{
	$syncLog = java -jar $($tools.Sync.FullName) $syncSwitches.split(" ") $source.fullName $target.FullName
}

if ($logFile -ne "Off" -and
    $logFile -ne "host")
{
	$syncLog | Out-File -FilePath $logFile -Append -Encoding ASCII
}

Pop-Location

if (-not $silent)
{
	$searchStrings = @("SYNCHRONIZATION REPORT",
 	"No. of source subdirectories scanned ",
	"No. of source files scanned ",
	"No. of target files scanned ",
	"No. of source files matched ",
	"No. of unmatched source files ",
	"No. of unmatched target files/directories ")
	
	$syncLog | Select-String -Pattern $searchStrings | Write-Host
}

return $true
