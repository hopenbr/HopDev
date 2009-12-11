#Get-InfoPathBuildNumber
#this script will be call during a team build of InfoPath 
#in the BuildNumberOverrideTarget
#It will return the build number which will be the sxn package name 
#and the date
#parameters are set as global variable by invoke-PSHScript task 
#uncommon below line to test locally 

#Param([string] $path2XSN = $(throw 'The Full UNC path to the XSN directory is required'),
#	  [string] $Env = $("PRD"))

[System.IO.DirectoryInfo] $xsnFolder 

if (Test-Path $path2XSN)
{
	$xsnFolder = Get-Item $path2XSN
}
else
{
	throw "ERROR: XSN directory does not exist"
}

[string] $dateStamp = $(get-Date).ToString("yyyyMMdd.HHmmss")
[string] $buildNumber = "" 

if ($xsnFolder.GetFiles().Count -eq 1)
{
	foreach ($xsn in $xsnFolder.GetFiles())
	{
		$buildNumber = $("LGBP.InfoPath.$Env." + $($xsn.name.remove($($xsn.Name.Length - $xsn.extension.length))) +  "-" + $dateStamp)
	}
}
elseif ($xsnFolder.GetFiles().Count -gt 1)
{
	$buildNumber = $("LGBP.InfoPath.$Env.MultipleForms-$dateStamp")
}
else
{
	throw "Error: There is not a signle file the XSN directory `($path2XSN`) directory cannot be empty"  
}

if ($buildNumber.Length -gt 64)
{
	$buildNumber = $buildNumber.remove(64)
}

return $buildNumber
