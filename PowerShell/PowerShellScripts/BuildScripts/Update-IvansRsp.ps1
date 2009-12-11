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
	[string] $rspPath = Join-Path $newBuildTypePath "TFSBuild.rsp"
	
	$ws.PendEdit($rspPath)
	
	$rsp = (gc $rspPath)
	
	$rsp = $rsp -replace "UpdateBuildNumber=false", "UpdateBuildNumber=true"
	
	$rsp = $rsp -replace "UseBuildNumber=false", "UseBuildNumber=true"
	
	$rsp = $rsp -replace "Deploy=false", "Deploy=true"
	
	$rsp = $rsp -replace "Deploy2Drop=false", "Deploy2Drop=true"
	
	Set-Content -Path $rspPath -Value $rsp
	
    $i++
	
}

$ws.CheckIn($ws.GetPendingChanges(), "RSP updated to turn on full releases") 

Write-Host "$i new Ivans rsp files were updated"