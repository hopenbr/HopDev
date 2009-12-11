#Upgrade-TFSDeployer2Hpp
#This script will take an old TFSDeployer script pre-Hpp and upgrade it up 
#to latest HPP TFS Deployer 

param([string] $path2Script = $(throw 'Error:   Full path to script to upgraded is required'))

function get-PathHashes ([array] $aht)
{
	foreach ($i in $aht)
	{
		if ($i.containskey("In-TST1"))
		{
			$i
		}
	}
}

function get-deployerScript ()
{
'##This is a kick off script only DO NOT edit

E:\TFS\HICPowerPlatform\TFSDeployerScripts\Deployer.ps1 $myInvocation.MyCommand.Definition'
}

function get-xmlTemplate ()
{
'<?xml version="1.0" encoding="utf-8"?>
<Settings value="go" >
</Settings>'
}


###MAIN####

if (-not (Test-Path $path2Script))
{
	throw "Error: Invalid path to script: $path2Script"
}


[string] $scriptFolder = split-path $path2Script -Parent
[string] $scriptName = Split-Path $path2script -Leaf
[string] $Dscript = gc $path2Script
[string] $getPathScript = $($path2Script -replace "\.ps1", "_1.ps1") 
[string] $path2DcXml = Join-Path $(split-path $getPathScript -Parent) "DeploymentConfig.xml"
[string] $path2Dmx = $(Join-Path $scriptFolder "DeploymentMappings.xml")
[regex] $rx = [regex] "\@\{.+?\}"

if (Test-Path $getPathScript)
{
	Remove-Item -Path $getPathScript -Force
}

$Dscript = $Dscript -replace "\s", " " 

$m = $rx.matches($Dscript)


foreach ($ms in $m)
{
	foreach ($g in $ms.groups)
	{
		$g.value | Out-File -Append -FilePath $getPathScript 
		
	}
}

$arrayOfHashes = & $getPathScript

$arrayofPathHashes = get-PathHashes $arrayOfHashes

$template = (get-xmlTemplate)
[xml] $x = [xml] $template

$packages = $x.CreateElement("Packages")

foreach ($paths in $arrayofPathHashes)
{
	$package = $x.CreateElement("Package")
	
	$package.SetAttribute("Deploy", "false")
	$package.SetAttribute("DeploymentType", "Simple")
	$package.SetAttribute("SyncType", "Full")
	$package.SetAttribute("PackageName", "")
	
	
	$drs = $x.CreateElement("DeploymentRegions")
	
	foreach ($k in $paths.keys)
	{
		if ($k -match "IRB")
		{
			continue
		}
		
		[string] $name = $($k.split("-"))[1]
		
		$dr = $x.CreateElement("DeploymentRegion")
		$dr.SetAttribute("Name", $name)
		
		$rls = $x.CreateElement("RegionLocations")
		
		foreach ($location in $($paths[$k].split(",")))
		{
			$l = $($location.split(";")[0])
			$loc = $x.CreateElement("Location")
			$loc.SetAttribute("Path", $l)
			$rls.AppendChild($loc) 
		}
		
		$dr.AppendChild($rls)
		$drs.AppendChild($dr)
		
	}
	
	$package.AppendChild($drs)
	
	$packages.AppendChild($package)

}

$ws = .\Get-TFSWorkspace.ps1 $scriptFolder

$x.Settings.AppendChild($packages)

$x.Settings.SetAttribute("xmlns", "urn:schema-Harleysvillegroup-com:TFSDeployerConfig")

$x.Settings.RemoveAttribute("value")

[bool] $isDCXmlPresent = $false

if (Test-Path $path2DcXml)
{
	$ws.PendEdit($path2DcXml)
	$isDCXmlPresent = $true
}

$x.Save($path2DcXml)

Remove-Item -Path $getPathScript -Force

cd $(Get-ItemProperty 'HKLM:\SOFTWARE\HGIC\SRM\HPP').Path

if($ws -eq $null)
{
	throw "Error: $scriptFolder is not mapped in a local workspace"
}

if (-not $isDCXmlPresent)
{
	$ws.PendAdd($path2DcXml)
}

$ws.PendEdit($path2Dmx)
$ws.PendEdit($path2Script)

get-deployerScript | Out-File -force -FilePath $path2Script -Encoding ASCII

Copy-Item -Path ".\TFSDeployerScripts\Templates\Template_DeploymentMappings.xml" -Destination $path2Dmx -Force

if ($scriptName -ne "Deploy.ps1")
{
	$(gc $path2Dmx) -replace "Deploy\.ps1", $scriptName | 
		Out-File -Force -FilePath $path2Dmx -Encoding "UTF8"
}
