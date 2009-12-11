param
(
	[string] $parentFolder = $(throw 'Package parent folder required'),
	[string] $buildName = $(throw 'Full build name is required'),
	[string] $workspaceHint = $(get-location).path,
	[string] $pathBuildNumberXml = $(".\BuildNumber-Template.xml"),
	[bool] $createTst1 = $true
)

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}



$script = get-script
$script_folder = split-path $script
Push-Location $script_folder
$tfs = .\Get-tfs.ps1 "Http://as73tfs01:8080"
$ws = .\Get-Tfsworkspace.ps1 $workspaceHint $false $tfs
$ws.Get()
#pop-location

if (!(Test-Path $parentFolder) -Or !(Test-Path $pathBuildNumberXml))
{
	throw "Error: Not a valid parent folder or Build number  path"
}

$bn = (Get-Content $pathBuildNumberXml)

foreach ($package in (Get-Childitem $ParentFolder | Where-Object {$_.Mode.Contains('d')}))
{
	$packageFullName = $(Join-Path $package.FullName $($package.Name + ".zip")) 
	$releasePath = $(Join-Path $package.FullName "Release")
	$tst1Path = $(Join-Path $package.FullName "TST1")
	$buildNumberPath = $(Join-Path $releasePath "\BuildNumber.xml")
	
	if ($createTst1)
	{
		if (!(Test-Path $tst1Path))
		{
			new-item -path $package.FullName -name "TST1" -type directory
		}
		
		$tst1 = Get-Item $tst1Path
		write-host $("TST1: " + $tst1.FullName)
		copy-item -path $packageFullName -dest $tst1.FullName
		$ws.PendAdd($(Join-Path $tst1.FullName "\*.zip"))
	}
	
	if (!(Test-Path $releasePath))
	{
		new-item -path $package.FullName -name "Release" -type directory
	}
	
	write-host $("Package: " + $packageFullName)
	
	$ws.PendRename($packageFullName, $(Join-Path $releasePath $($package.Name + ".zip")))
	
	$bn -replace "BuildName", $($buildName + $package.Name) | set-content -path $buildNumberPath
	
	$ws.PendAdd($buildNumberPath)
	
}






    	
	