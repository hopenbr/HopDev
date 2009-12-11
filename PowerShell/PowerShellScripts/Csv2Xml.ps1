param([string] $csvPath = $(throw 'The full path to the csv file to be converted is required'))

if (!(Test-Path (Split-path $csvPath)))
{
	
	new-item -path (Split-Path (Split-path $csvPath) -parent) -name (Split-Path (Split-path $csvPath) -leaf) -ItemType directory
}

$csv = Import-Csv $csvPath
$packageHash = @{}
[int] $count = 0

foreach ($package in $csv)
{
	if ($package.sdlc -eq "SBX" -or 
	    $package.Package -eq $null -or
	    $package.sdlc -eq "PRD2")
	{
		continue
	}
	
	$sdlc = $package.sdlc
	
	if ($package.sdlc -eq "PRD1")
	{
		$sdlc = "PRD"
	}
	
	if (!$packageHash.ContainsKey($package.Package))
	{
		$packageHash.add($package.Package, @{"ASY" = @{};
											 "TST1" = @{};
											 "TST2" = @{};
											 "E2E" = @{};
											 "TRN" = @{};
											 "PRE" = @{};
											 "PRD" = @{}})
	}
	
	$packageHash.$($package.Package).$($sdlc).Add(($package.Location + ":" + $count), ("<Search Regex=`"" + $package.Search + "`" Replace=`"" + $package.Replace + "`" />"))
	$count++
	
}

[string] $cnfXml = "<?xml version=`"1.0`"  encoding=`"utf-8`" ?>`n<Packages>`n"

foreach ($key in $packageHash.keys)
{
	$cnfXml += ("`t<Package Name=`"" + $key +"`">`n`t`t<Environments>`n")
	
	foreach ($env in ($packageHash.$key.keys | sort))
	{
		$cnfXml += ("`t`t`t<Environment Name=`"" + $env + "`" >`n")
		[int] $count = 0
		
		foreach ($endpoint in $packageHash.$key.$env.keys)
		{
			if ($count -eq 0)
			{
				$cnfXml += "`t`t`t`t<Searches FileName2Search=`"" + (split-path ($endpoint.split(":"))[0] -leaf) + "`">`n"
			}
			
			$cnfXml += ("`t`t`t`t`t" + $packageHash.$key.$env.$endpoint + "`n")
			$count++
		}
		
		if ($count -eq 0)
		{
			$cnfXml += "`t`t`t`t<Searches/>`n`t`t`t</Environment>`n"
		}
		else
		{
			$cnfXml += ("`t`t`t`t</Searches>`n`t`t`t</Environment>`n")
		}
	}
	
	$cnfXml += ("`t`t</Environments>`n`t</Package>`n")
	
}

$cnfXml += ("</Packages>`n") 

set-content -value $cnfXml -Path ("C:\Projects\SRM\Branches\INTEGRATION\PowerShell\PowerShellScripts\webMethodsScripts\wMEnvSearchAndReplaceMappings.xml")