#This scripts will added a cloaked xml node to the workspacemapping.xml 


param($localPath4workspace = $(throw 'Base local path for workspace is required'),
	[string] $serverPath2BeCloaked = $(throw 'TFVC server path to be claoked is required'),
	[switch] $debug)
	

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

if ($debug -and $DebugPreference -ne "Continue")
{
	$DebugPreference = "Continue"
}

Write-Debug "Starting"

$script = get-script
$script_folder = split-path $script

Push-Location $script_folder

if (Test-Path $localPath4workspace)
{
	$tfs = ..\Get-tfs.ps1 "Http://as73tfs01:8080"
	$ws = ..\Get-Tfsworkspace.ps1 $localPath4workspace $false $tfs
	$ws.Get()
}
else
{
	throw "Error: workspace local path does not exisit $localPath4workspace"
}
pop-location

foreach ($dir in (Get-Childitem | where {$_.Mode.Contains("d") -and $_.Name.Contains(".Release")}))
{
	Write-Debug "Dir => " + $dir.FullName
	
	foreach ($file in (Get-ChildItem $(Join-Path $dir.FullName "*") -Include *.xml))
	{
		Write-Debug "File: " + $file.FullName
		
		$xml = [xml] (Get-Content $file.FullName)
		
		if ($xml.SerializedWorkspace.Mappings.SelectSingleNode("InternalMapping[@ServerItem='$serverPath2BeCloaked']"))
		{
			Write-Debug "skipping b/c Mapping found" 
		}
		else
		{
			$ws.PendEdit($file.FullName)
		
			$newNode = $xml.CreateElement("InternalMapping")
			$newNode.SetAttribute("ServerItem", $serverPath2BeCloaked)
			$newNode.SetAttribute("LocalItem", "E:\Builds\")
			$newNode.SetAttribute("Type", "Cloak")
			$xml.SerializedWorkspace.Mappings.AppendChild($newNode)
			
			$xml.Save($file.FullName)
			
			Write-Debug "Updated saved"
		}
	}
}

Write-Debug "Complete and ready to checkIn"

if ($(Read-Host "CheckIn? [Y/N] ") -eq "y")
{
	$ws.CheckIn($ws.GetPendingChanges(), "Added: $serverPath2BeCloaked to cloaked list of build workspace")
}

