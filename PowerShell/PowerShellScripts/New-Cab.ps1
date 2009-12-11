##New-Cab.ps1
#this script will take the directory passed in and create a Compressed file (CAB) file
#of the entire contains of the directory 
#a FileInfo object of the new cab file is returned 
##
#This Scripts depences of the Open Source WspBuilder CabLib.dll 
##

param([string] $path2Template = $(throw 'The absolute local path to directory that will be compressed is required'), 
	  [string] $path2Cab = $(throw 'The absolute local path to the cab file that will be crreated'))

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

$cablib = get-item $(Join-path $(split-path (Get-script) -Parent) "\References\WSPBuilder\CabLib.dll")

[void][reflection.assembly]::LoadFile($cablib.FullName)

$c = new-object CabLib.Compress

$c.CompressFolder($path2Template, $path2Cab, $null, 0)

$cab = get-item  $path2Cab


return $cab