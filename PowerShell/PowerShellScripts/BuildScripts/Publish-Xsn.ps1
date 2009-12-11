##Publish-Xsn.ps1 
#This scripts will create the cab file and rename it XSN 
#the Cab will compress the InfoPath Form Template Directory 
#from the VSTO InfoPath Template project, this directory must 
#contain the entire contents of the InfoPath from including
#all dlls, xsd, xsf, etc 
# 

param([string] $path2Template = $(throw 'The absolute local path to InfoPath Template directory is required'), 
	  [string] $path2Pub = $(throw 'The absolute local path where xsn should be published is required'), 
	  [string] $xsnName = $(throw 'The name of the xsn package is required w/o extension'))

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

pushd $(split-path (Get-script) -Parent)

$path2Cab = $(Join-Path $path2Pub $("Cab_" + $(Get-Date).ToString("yyyyMMddhhmmss") + ".cab"))

$cab = ..\New-Cab.ps1 $path2Template $path2Cab

#To turn CAB into published InfoPath MOSS from all you need to rename from .cab to .xsn 

if (!$xsnName.EndsWith(".xsn"))
{
	$xsnName += ".xsn"
}

rename-item $cab.FullName -newname "$xsnName"

popd

if ($cab.Exists)
{
	$host.SetShouldExit(0)
	return $true
}
else
{
	$host.SetShouldExit(1)
	return $false
}
