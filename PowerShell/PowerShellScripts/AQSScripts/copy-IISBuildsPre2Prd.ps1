Param([string] $path2BuildFolder = $(throw 'The full UNC patht to the PRE IIS build folder is required'),
      [string] $buildNumber = $(throw 'The build number is needed'))

function Get-Dest ([string] $c)
{
"\\ws73aqsprd0$c\e`$\Install\AQS Advantage\Ready4Install"
}

###MAIN###

for($i=1;$i -le 8;$i++)
{
	if(-not (Test-Path $path2BuildFolder))
	{
		throw "ERROR: invalid path to PRE; $path2BuildFolder"
	}
	
	$from = gi $path2BuildFolder
	[string] $destFolder =  $(Get-Dest $i)

	
	if (-not (Test-Path $destFolder))
	{
		New-Item -Path $(Split-Path $destFolder -Parent) -Name $(Split-Path $destFolder -leaf) -ItemType Directory | out-null
	}
	
	$dest = gi $destFolder
	
	
	Write-Host "Copy to: $destFolder"
	copy -Path $from -Destination $dest -Force -Recurse 
	
	
}