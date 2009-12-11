param(
    [string] $workspaceHint = $(get-location).Path,
    [string] $sourcePath = $(throw 'The source branch path is required'),
    [string] $targetPath = $(throw 'The target branch path is required'),
    $tfs = $null 
)

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

$script = get-script
$script_folder = split-path $script

if (!$tfs)
{
	Push-Location $script_folder
	$tfs = .\Get-tfs.ps1 "Http://as73tfs01:8080"
	pop-location
}

$results = @{}
$results.add("wasMergeSuccessful", $true)
$results.add("errorMessage", '')

Push-Location $script_folder
$ws = .\Get-TfsWorkspace.ps1 $workspaceHint $true $tfs


if(!$ws)
{
	$wsName = 'AgentPortalNightlyMerger'
	$ws = .\Get-TfsWorkspace.ps1 $wsName $true $tfs
	if (!$ws)
	{
		#no workspace found need to create one
		$ws = $tfs.vcs.CreateWorkspace($wsName)
	}
	
}

pop-location 

if (!$ws.IsServerPathMapped($targetPath))
{
	$ws.map($targetPath, $workspaceHint) 
}

$getResults = $ws.Get()

if ($getResults.NumConflicts > 0)
{
	$results["wasMergeSuccessful"] = $false
	$results["errorMessage"] = "There were conflicts when try to get latest code"
	return $results
}


$mergeResults = $ws.Merge($sourcePath, 
		     $targetPath, 
		     $null, 
		     [Microsoft.TeamFoundation.VersionControl.Client.VersionSpec]::Latest,
		     [Microsoft.TeamFoundation.VersionControl.Client.LockLevel]::None,
		     [Microsoft.TeamFoundation.VersionControl.Client.RecursionType]::Full,
		     [Microsoft.TeamFoundation.VersionControl.Client.MergeOptions]::None)

if ($mergeResults.NumConflicts > 0)
{
	$ws.Undo($ws.GetPendingChanges())
	$results["wasMergeSuccessful"] = $false
	$results["errorMessage"] = "Merge has conflict, pending changes have be undone, manual merge needed"
	return $results
}


if ($mergeResults.NumOperations -eq 0)
{
	$results["wasMergeSuccessful"] = $false
	$results["errorMessage"] =  "No changes to merge"
	return $results
}

$checkInResults = $ws.CheckIn($ws.GetPendingChanges(), $("Merge from " + $sourcePath + "to " + $targetPath ))	

if ($checkInResults -eq 0)
{
	$ws.Undo($ws.GetPendingChanges())
	$results["wasMergeSuccessful"] = $false
	$results["errorMessage"] = "Checkin after merge has conflicts, merge backed out, please attend to this issue"
	return $results
	
}

return $results
		     

