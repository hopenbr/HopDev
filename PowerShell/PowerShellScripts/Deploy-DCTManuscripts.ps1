#Deploy-DCTManuscripts
#

param([string] $SourceRegion = $(throw 'source share is required'),
      [string] $TargetRegion = $(throw 'target share is required'),
	  [string] $path2FileList = $(throw 'path to files txt is required'),
	  [string] $dbiNum = $(throw 'The dbi number is required'),
	  [bool] $whatif = $($true),
	  [switch] $NewItems)
	  


function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

function get-CopyCmd ([string] $s, [string] $t)
{
	"[string] `$f = `"$(split-path $s -leaf)`"
[string] `$td = `"$(split-path $t -parent)`"
write-host `"Copying file: `$f`"
write-host `"Destination: `$td`"
#file: $t 
Copy-Item -path `"$s`" -Destination `"$t`" -force

#####"
}

function Get-RegionShare([string] $region)
{
	switch ($region) {
		"DEV" {"\\as73dctdev01\ManuScripts"}
		"E2E" {"\\as73dcte2e01\ManuScripts"}
		"QA2" {""}
		"PRE" {"\\fs73dct01\ManuScripts"}
		"PRD" {"\\fs73dctprdsvr\Common\ManuScripts"}
		default {Throw "ERROR: Invalid region: $region Passed in"}
	}
}

function get-DateTimeStamp
{
$(Get-Date).ToString("yyyyMMdd_hhmmss")
}

###MAIN###

$ErrorActionPreference = "Stop" 

pushd $(Split-Path $(get-Script) -Parent)

[string] $dtStamp = get-DateTimeStamp

$path2Target = Get-Item $(get-RegionShare $targetRegion)
$path2Source = Get-Item $(get-RegionShare $sourceRegion)

$target = Get-Item $path2Target
$source = Get-Item $path2Source

$fileList = gc $path2fileList
$files = ls $source -Recurse -Include $fileList

[string] $cmdPath = "C:\Cmd_DBI_$dbiNum`.ps1"
[string] $listPath = "C:\filelist_DBI_$dbiNum`.txt"

if(Test-Path $cmdPath)
{
	Remove-Item -Path $cmdPath -Force
}

if(Test-Path $listPath)
{
	Remove-Item -Path $listPath -Force
}

foreach ($file in $files)
{
	[string] $bkupFolder = "c:\archived_logs\$dbiNum"
	
	if (-not (Test-Path $bkupFolder))
	{
		
		New-Item -Name $(Split-Path $bkupFolder -leaf) -Path $(Split-Path $bkupFolder -Parent) -ItemType Directory | out-null
	}
	
	$copyTo = $file.fullName -replace $($($path2Source -replace "\\", "\\") -replace "\$", "\$" ), $path2Target
	
	if ($(Test-Path $copyTo))
	{
		gi $copyTo | write-zip -level 5 | move-item -Destination $bkupFolder -Force
	}
	elseif($NewItems)
	{
		Write-Warning "Destination location not found: $copyTo"
		Write-Warning "for $($file.FullName)"
	}
	else
	{
		Write-Error "Destination location invalid: $copyTo for $($file.FullName)"
	}
	
	get-CopyCmd $file.FullName $copyTo | out-file -FilePath $cmdPath -Append
	$file.Name | Out-File -FilePath $listPath -Append
	
	
}