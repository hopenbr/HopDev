param ([string] $packageName = $(throw 'new wM Package name is required'), 
	   [string] $projName = $(throw 'wM Project is needed CL/PL/Common'),
	   [string] $configName = $("Service.cnf"))


function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else{ $myInvocation.MyCommand.Definition }
   
} 

function get-ProjectName ($name)
{
	[string] $rt = "wM."
	
	switch ($name)
	{
		"CL" {$rt += "CL"}
		"PL" {$rt += "PL"}
		"COMMON" {$rt += "COMMON"}
		default {throw "Invalid wM project passed in, Myst CL, PL, or COMMON"}
	}
	
	return $($rt + ".")
}

function get-ProjectDirName ($name)
{
	[string] $rt = ""
	
	switch ($name)
	{
		"CL" {$rt += "CommercialLines"}
		"PL" {$rt += "PersonalLines"}
		"COMMON" {$rt += "COMMON"}
		default {throw "Invalid wM project passed in, Myst CL, PL, or COMMON"}
	}
	
	return $rt
}

function get-BuildNumberXml ([string] $name)
{
	"<?xml version=`"1.0`" encoding=`"utf-8`"?>
<project>
  <BuildNumber Name=`"$name`">
    <Major>1</Major>
    <Minor>0</Minor>
    <Fix>0</Fix>
    <Build>0</Build>
  </BuildNumber>
</project>"
}


###MAIN###

pushd $(split-path $(get-script))

Write-Debug "Starting wM package creation work..."

[string] $dateStamp = $(Get-Date).ToString("yyyyMMdd")

[string] $localPath4workspace = "C:\temp\$dateStamp\wM\" + $packageName + "_" + $dateStamp
[string] $serverPath4wMPackage = "$/WmProjects/WmSourceControl/" + $(get-ProjectDirName $projName)
[xml] $buildNumberXml = get-BuildNumberXml $($(get-ProjectName $projName) + $packageName)

$tfs = ..\Get-Tfs.ps1 

[string] $wsName = "WS_WM_$dateStamp`_$packageName"

Write-Debug "Creating temp workspace $wsName"

$ws = ..\Get-TfsWorkspace $wsName $true $tfs

if ($ws -eq $null)
{
	$ws = $tfs.vcs.CreateWorkspace($wsName)
}

$ws.map($serverPath4wMPackage, $localPath4workspace)

$package = New-Item -ItemType "File" -Path $(Join-Path $localPath4workspace $($packageName + "\Release")) -Name $($packageName + ".zip") -Force
$buildNumberXml.Save($(Join-path $($package.Directory).FullName "BuildNumber.xml"))

Write-Debug "Adding place holders" 

foreach ($file in $(ls -Path $($package.Directory).FullName))
{
	$ws.PendAdd($file.FullName) | out-null
}



#$ws.deleteMapping($ws.GetWorkingFolderForLocalItem($localPath4workspace)) | out-null

Write-Debug "Adding Configs..." 

.\add-wMConfig.ps1 $packageName $ws $localPath4workspace $configName | out-null

Write-Debug "Creating New Team build type..." 

$TeamBuildName = .\new-wMTeamBuildType.ps1 $packageName $projName $ws $localPath4workspace

Write-Debug "Deleting temp workspace" 

$ws.delete() | Out-Null

popd

Remove-Item -Path $localPath4workspace -Force -Recurse

[string] $returnVal = "wM package has been successfully created`n $TeamBuildName"

Write-debug $returnVal

return $returnVal

