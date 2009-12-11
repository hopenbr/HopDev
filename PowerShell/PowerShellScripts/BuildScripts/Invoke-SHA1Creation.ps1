#Invoke-SHA1Creation
#this script will take all files in a directory and create SHA1 hash key file for them 
#this script is designed to be call from MSBUILD

param([string] $path2Dir = $(throw 'The Full UNC path to the directory is required'),
      [string] $fileTypes = $("*.*"),
	  [bool] $recursive = $($false))

trap
{
	$host.SetShouldExit(2)
	return $false
}


function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}


###MAIN### 

if (Test-Path $path2Dir)
{
	[System.IO.DirectoryInfo] $dir = Get-Item $path2Dir
	
	cd $(split-path (Get-script) -Parent)
	
	[System.IO.FileInfo] $nfsha1 = Get-Item "..\New-FileSha1.ps1"
	
	[string] $recurse = ""
	
	if ($recursive)
	{
		$recurse = "-recurse"
	}
	
	ls $(Join-Path $dir.FullName $fileTypes) $recurse | & $nfSha1 $true 
	
	$host.SetShouldExit(0)
	
	return $true
	
}
else
{
	$host.SetShouldExit(1)
	return $false
}

