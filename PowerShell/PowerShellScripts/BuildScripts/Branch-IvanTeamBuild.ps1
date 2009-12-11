param([string] $teamBuildBaseDir = $("C:\Temp\Agency\TeamBuildTypes"),
      [string] $baseTeamBuild = $("Agency.Ivans.HARLEYHO.Release"),
	  [string] $baseIvansBuild = $("HARLEYHO"),
	  [string] $workspaceDir = $("C:\Temp\Agency\Branches\INTEGRATION\Ivans"))



$ws = ..\Get-TfsWorkspace.ps1 $workspaceDir
[int] $i = 0

foreach ($dir in $(Get-ChildItem $workspaceDir | Where {$_.Mode.Contains("d")}))
{
	if ($dir.Name -eq "Build" -or $dir.Name -eq $baseIvansBuild -or $dir.Name -eq "HARLEYPA") { continue }
	
	[string] $newIvansBuildName = $dir.Name
	[string] $newBuildTypeName = $baseTeamBuild -replace $baseIvansBuild, $newIvansBuildName
	[string] $newBuildTypePath = Join-Path $teamBuildBaseDir $newBuildTypeName
	
	$ws.PendBranch("$teamBuildBaseDir\$baseTeamBuild","$teamBuildBaseDir\$newBuildTypeName", [Microsoft.TeamFoundation.VersionControl.Client.LatestVersionSpec]::Latest)
	
	$ws.CheckIn($ws.GetPendingChanges(), "Branching from $baseTeamBuild") 
	
	ls $newBuildTypePath -rec | where {!$_.Mode.Contains("d")} | %{$ws.PendEdit($_.FullName); $(gc $_.FullName) -replace $baseIvansBuild, $newIvansBuildName | out-file $_.FullName}
	
	$ws.CheckIn($ws.GetPendingChanges(), "File updated for $newBuildTypeName") 
	
    $i++
	
}

Write-Host "$i.ToString() new Ivans builds were created"