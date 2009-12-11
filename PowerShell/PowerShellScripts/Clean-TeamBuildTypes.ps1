#Clean-TFSTeamBuildByProject
##This Script will clean up the Team build section of a particular Team Project 
#It will delete the build from TFS, BuildStore and Global Lists 
#rules for deletion will be held in the config file for the script 
#Released builds will not be deleted 
#Dev build be delete via age of build (all that are 6 months or older) 

param ([string] $teamProj = $(throw "The Name of the Team Project is required"),
       [string] $buildType = $(throw "The Name of the Team Build Type is required"),
	   [int] $daysOld = $(180),
	   [switch] $noPrompt,
	   [switch] $listOnly,
	   [switch] $deleteGlobalListOnly,
	   [switch] $deleteBuildsOnly)



function get-script
{
if($myInvocation.ScriptName) { $myInvocation.ScriptName }
else { $myInvocation.MyCommand.Definition }
}


###MAIN####
[void] [Reflection.Assembly]::LoadWithPartialName("Microsoft.TeamFoundation.VersionControl.Client")


pushd $(Split-Path (get-script) -Parent)

Set-Alias -Name tfsb -Value "C:\Program Files\Microsoft Visual Studio 9.0\Common7\IDE\TFSBuild.exe" -Scope Script

$tfs = .\Get-Tfs.ps1 

$builds = $tfs.TBP.GetListOfBuilds($teamProj, $buildType)

$timespan = New-TimeSpan -Days $daysOld

$builds2Delete = @()


Foreach ($build in $builds)
{
	if ($build.BuildStatus -ne "Successfully Completed")
	{
		$builds2Delete += $build.BuildNumber
	}
	else
	{
		$touchedtimeSpan = New-TimeSpan -Start $build.FinishTime -End $(Get-Date)
		$releasePath = "`$/$teamProj/Releases/" + $build.BuildNumber
		
		if ($touchedtimeSpan -gt $timespan -and 
		    -not ($tfs.VCS.ServerItemExists($($releasePath), [Microsoft.TeamFoundation.VersionControl.Client.ItemType]::Folder)))
		{
			$builds2Delete += $build.BuildNumber
		}
		else
		{
			continue
		}
	}
	
}

if (-not $noPrompt)
{
	Write-Host "Team Project: $teamProj" -ForegroundColor Yellow
	Write-Host "Team Build Type: $buildType" -ForegroundColor Yellow
	Write-Host "Number of builds to be deleted: " $builds2Delete.Count -ForegroundColor Yellow
	Write-Host
}

if($listOnly)
{
	$builds2Delete
}
elseif ($noPrompt)
{
	if (-not $deleteGlobalListOnly)
	{
		tfsb delete /noprompt "AS73TFS01" $teamProj $builds2Delete
	}
	
	if (-not $deleteBuildsOnly)
	{
		$builds2Delete | .\Remove-TFSGlobalListEntries.ps1 "Builds - $teamProj" -silent
	}
}
else
{
	if (-not $deleteGlobalListOnly)
	{
		tfsb delete "AS73TFS01" $teamProj $builds2Delete
	}
	
	if (-not $deleteBuildsOnly)
	{
		$builds2Delete | .\Remove-TFSGlobalListEntries.ps1 "Builds - $teamProj"
	}
}
