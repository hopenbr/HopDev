param(
    [string] $base = $(throw 'base dir path to teambuildtypes folder is required'),
    [string] $serverItemBase = $(throw 'Server item base path is required'),
    [string] $BranchPath = $(throw 'The base path to branch is required'),
    $excluded = $null,
    [string] $type = "Cloak"
)

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

function check-exclusionList ([string] $currentDirName)
{
	[bool] $rtn = $false
	
	foreach ($ex in $excluded)
	{
		if ($ex.Name.equals($currentDirName))
		{
			$rtn = $true
		}
	}
	
	return $rtn
}

set-psdebug -strict

$script = get-script
$script_folder = split-path $script
Push-Location $script_folder
$tfs = .\Get-tfs.ps1 "Http://as73tfs01:8080"
$ws = .\Get-Tfsworkspace.ps1 $(Split-Path $base -parent) $false $tfs
$ws.Get()
pop-location


foreach ($dir in (Get-Childitem $base | Where-object {$_.Mode.Contains("d")}))
{
	Write-Host $dir
	
	if (!$(check-exclusionList($dir.Name)))
	{	
		foreach ($file in (Get-Childitem (Join-Path $dir.FullName "*") -include *.xml ))
		{
			$xml = [xml] (Get-Content $file.FullName)
			[bool] $checkedOut = $false
			
			foreach ($proj in (Get-Childitem $branchPath | Where-object {$_.Mode.Contains("d")}))
			{
			
				$serverItem = $($serverItemBase + "/" + $proj)
				
				if ($xml.SerializedWorkspace.Mappings.SelectSingleNode("InternalMapping[@ServerItem='$serverItem']") -or 
				    $dir.Name.Contains($proj))
				{
					Write-host $("Skipped add of " + $serverItem + " to " + $file.FullName)
					continue
				}
				
				if (!$checkedOut)
				{
					$ws.PendEdit($file.FullName)
					Write-host $("Checked out: " + $file.FullName)
					$checkedOut = $true
				}
				
				$newNode = $xml.CreateElement("InternalMapping")
				$newNode.SetAttribute("ServerItem", $serverItem)
				$newNode.SetAttribute("LocalItem", "E:\Builds\")
				$newNode.SetAttribute("Type", $type)
				$xml.SerializedWorkspace.Mappings.AppendChild($newNode)
				
			}
			
			if ($checkedOut)
			{
				$xml.Save($file.FullName)
			}
				
		}
		
	}
}