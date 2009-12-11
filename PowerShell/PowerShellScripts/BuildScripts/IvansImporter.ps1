#Ivans Importer will be called from TeamBuild via exec task 
#It will leverage the DevImporter script to compare Ivans Scripts files
#in the Dev region to those in TFVC 
#The Dev region holds the truth and any difference with pulled from Dev 
#into TFV
#This Script will be very parameter heavy 
#PARAMETRS:
#0 Build Number: $(BuildNumber) in teambuild
#1 TFS URL: $(TeamFoundationServerUrl) in teambuild
#2 Workspace name: $(WorkspaceName) in teambuild
#3 base folder of Workspace: $(SolutionRoot) in teambuild
#4 The team build type : $(BuildType) in teambuild

param([string] $buildNumber = $(Throw 'The Build Number is required'),
	  [string] $tfsUrl = $(throw 'The url to TFS is required'),
	  [string] $wsName = $(throw 'The name of the workspace is required'),
	  [string] $path2Source = $(throw 'The local path of the workspace is required'),
	  [string] $buildType = $(throw 'The buidl type is required'))

trap
{
	$host.SetShouldExit(2)
	return $false
}	  

[xml] $config = [xml] (gc $(Join-Path $path2Source "Branches\INTEGRATION\Ivans\Build\Configs\Ivans.Config.xml"))

#Build type name must be in this format: Agency.Ivans.(IvansType).Release
[regex] $regex_IvansType = [regex] "(\w+?)[\.-]"

[string] $ivansType = $regex_IvansType.Matches($buildType)[2].Groups[1].Value

[string] $path2SaveLocation = "$env:Temp\Ivans`.$ivansType`.Config.xml"

if ($wsName.Length -gt 64)
{
	$wsName = $wsName.Remove(64)
}

$config.Settings.TFSUrl = $tfsUrl
$config.Settings.Workspace.Name = "$wsName"
$config.Settings.Workspace.BaseDir = $path2Source
$config.Settings.CheckInComment = "Checkin for build $buildNumber"
$config.Settings.Shares.Share.Target += "\$ivansType"
$config.Settings.Shares.Share.TFVC.ServerPath += "/$ivansType"
$config.Settings.Shares.Share.TFVC.SubFolder += "\$ivansType"
$config.Settings.EventSource = $config.Settings.EventSource -replace "\.Ivans\.", "`.Ivans`.$ivansType`."


if (Test-Path $path2SaveLocation)
{
	Remove-Item -Path $path2SaveLocation -Force 
}

$config.Save($path2SaveLocation)

Set-Location $config.Settings.CommonScriptsLocation

$results = .\ImportScripts\DevImporter\DevImporter.ps1 $path2SaveLocation $false 


if ($results -eq $true)
{
	$host.SetShouldExit(0)
	return $true
}
else
{
	$host.SetShouldExit(1)
	return $false
}

