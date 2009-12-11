##Add-wMConfig.ps1 
#this script will added the blank configs to Source control 
#this scripts is designed to called from New-wMBuildPackage.ps1 


param ([string] $packageName = $(throw 'The package name is required'),
	   [Microsoft.TeamFoundation.VersionControl.Client.Workspace] $ws = $(throw 'The TFVC workspace object is required'),
	   [string] $localPath4workspace = $(throw 'The path to the local directory the workspace should be mapped to is required'),
	   [string] $fileName = $("Service.cnf"),
	   [string] $serverPath4wMPackage = $("$/WmProjects/WmSourceControl/Config"))


###MAIN###

$localConfigs = $(Join-Path $localPath4workspace "configs")

$ws.map($serverPath4wMPackage, $localConfigs)
$ws.Get()

Push-Location -Path $localConfigs 

foreach ($dir in (Get-ChildItem -Path . | Where-Object {$_.Mode.Contains("d")}))
{
	[string] $path2ConfigDest = (Join-Path $dir.FullName "Packages\$packageName\Config")
	
	if (!(Test-Path $path2ConfigDest))
	{
		 New-Item -Path (Split-path $path2ConfigDest -parent) -Name "Config" -ItemType directory
	}
	
	$config = New-Item -Path $path2ConfigDest -Name $fileName -ItemType file -Force
	
	#Copy-Item -Path $path2Config -Destination $path2ConfigDest

	$ws.pendAdd($config.FullName)
}

popd

#$results = $ws.Checkin($ws.GetPendingChanges(), "Adding place holder for new wM package configs for $packageName to TFVC")
#
#$ws.deleteMapping($ws.GetWorkingFolderForLocalItem($localConfigs)) | out-null

#Remove-Item -Path $localConfigs -Recurse -force
