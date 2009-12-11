#New-WmTeamBuildType 
#this is designed to be called via New-wMbuildpackage scripts 
#but it can be called stand-alone  
#
#This scripts will create a new team build type on Wm project

param([string] $packageName = $(throw 'new wM Package name is required'), 
	  [string] $projName = $(throw 'wM Project is needed CL/PL/Common'),
	  [Microsoft.TeamFoundation.VersionControl.Client.Workspace] $ws = $(throw 'The TFVC workspace object is required'),
	  [string] $localPath = $(throw 'The path to the local directory the workspace should be mapped to is required'))
	  


$localTbs = $(Join-Path $localPath "TeamBuilds")

$ws.map('$/WmProjects/TeamBuildTypes', $localTbs)
$ws.Get() | Out-Null

#we need to get a build type to model the new build type after 
#therefore we need to figure what type of build type it is 
[string] $tbtModelName = ''
[string] $tbtModelPackageName = ''

if ($projName -eq "pl")
{
	$tbtModelName = "wM.PL.HmiDCTISOPPC.Release"
	$tbtModelPackageName = "HmiDCTISOPPC"
}
elseif ($projName -eq "cl")
{
	$tbtModelName = "wM.CL.HmiRenewal.Release"
	$tbtModelPackageName = "HmiRenewal"
}
elseif ($projName -eq "commmon")
{
	$tbtModelName = "wM.Common.HmiCommon.Release"
	$tbtModelPackageName = "HmiCommon"
}
else
{
	throw "Error: Invalid Project type passed in, needs to be PL, CL or Common"
}

#here we will copy the model type to the new types folder and make the updates
#needed
$modelType = Get-Item (Join-Path $localTbs $tbtModelName)

$newTBTName = "wM`.$projName`.$packagename`.Release"

$newTbtDir = Join-Path $localTbs $newTBTName

Copy-Item -Path $modelType -Destination $newTbtDir -Recurse

$pt = $(Join-Path $newTbtDir "TFSBuild.proj")
$pw = $(Join-Path $newTbtDir "WorkspaceMapping.xml")

#making changes needed for new build type 
$($(gc (Join-Path $newTbtDir "TFSBuild.proj")) -replace $tbtModelPackageName, $packageName) | Out-File -FilePath $pt -Encoding "UTF8" -Force
$($(gc (Join-Path $newTbtDir "TFSBuild.proj")) -replace "E:\\Builds\\wM\\CL", "E:\Builds") | Out-File -FilePath $pt -Encoding "UTF8" -Force
$($(gc (Join-Path $newTbtDir "WorkspaceMapping.xml")) -replace $tbtModelPackageName, $packageName) | Out-File -FilePath $pw -Encoding "UTF8" -Force

[string] $rsp = (Join-Path $newTbtDir "TFSBuild.rsp")

$(gc $rsp) -replace "true", "false" | Out-File -FilePath $rsp -Force

#add the new files to TFVC
foreach ($file in (ls $newTbtDir -Recurse))
{
	$ws.PendAdd($file.FullName) | Out-Null
}

#check in the files added
[string] $results = "Changesets: "

$results += $ws.Checkin($ws.GetPendingChanges(), "Adding Team Build Type for new wM package $packageName")

Write-Debug "kicking off build..."

.\Start-TeamBuild.ps1 "WmProjects" $newTBTName | out-null

$ws.pendEdit($rsp) | out-null

$(gc $rsp) -replace "false", "true" | Out-File -FilePath $rsp -Force

$(gc $rsp) -replace "IsHotFix=true", "IsHotFix=false" | Out-File -FilePath $rsp -Force

$results += ", " + $ws.Checkin($ws.GetPendingChanges(), "Setting build type $packageName back to full release build")

#cleanup 

$ws.deleteMapping($ws.GetWorkingFolderForLocalItem($localTbs)) | out-null

Remove-Item -Path $localTbs -Recurse -force

Write-Debug "New Team Build Name: $newTBTName"

return $($results + "`nTeam Build Name: " + $newTBTName)
