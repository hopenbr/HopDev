# Script to find a Team Foundation workspace
param(
    [string] $workspaceHint = $(get-location).Path,
    [bool] $continueOnError = $($false),
    $tfs = $($null)
)

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

    
###MAIN###

# load the needed client dll's
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.TeamFoundation.Client")
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.TeamFoundation.VersionControl.Client")
    
if (!$tfs)
{
	$script_folder = split-path $(get-Script)
	Push-Location $script_folder
	$tfs = .\Get-tfs.ps1 "Http://as73tfs01:8080"
	pop-location
}

$wsCurrent = [Microsoft.TeamFoundation.VersionControl.Client.Workstation]::Current

$wsCurrent.UpdateWorkspaceInfoCache($tfs.vcs,$tfs.vcs.TeamFoundationServer.AuthenticatedUserName)

#get workspace info for local machine via cache
$workspaceInfos = $wsCurrent.GetAllLocalWorkspaceInfo()


# is there only 1 workspace in our cache file?  If so, use that one regardless of the hint
if ($workspaceInfos.Length -eq 1)
{
    return $tfs.vcs.GetWorkspace($workspaceInfos[0])
}

if (test-path $workspaceHint)
{
    # workspace hint is a local path, get potential matches based on path
    # is the path itself mapped?
    $workspaceInfos = $wsCurrent.GetLocalWorkspaceInfo((resolve-path $workspaceHint))
    if ($workspaceInfos -ne $null)
    {
        # this path is mapped, so we go with this workspace info in an array by itself
        $workspaceInfos = @($workspaceInfos)
    }
    else
    {
        # this path isn't mapped, so we do a recursive check instead
        $workspaceInfos = $wsCurrent.GetLocalWorkspaceInfoRecursively((resolve-path $workspaceHint))
    }
}
else
{
    # workspace hint is NOT a local path, get potential matches based on name
    $workspaceInfos = @($workspaceInfos | ?{ $_.name -match $workspaceHint })
}

if ($workspaceInfos.Length -gt 1)
{
	if ($continueOnError)
	{
		return $null
	}
	else
	{
    	throw 'More than one workspace matches the workspace hint "{0}": {1}' -f
            	$workspaceHint, [string]::join(', ', @($workspaceInfos | %{ $_.Name}))
    }
    
}
elseif ($workspaceInfos.Length -eq 1)
{
    return $tfs.vcs.GetWorkspace($workspaceInfos[0])
}
else
{
	if ($continueOnError)
	{
		return $null
	}
	else
	{
    	throw "Could not figure out a workspace based on hint $workspaceHint"
    }
    
}
