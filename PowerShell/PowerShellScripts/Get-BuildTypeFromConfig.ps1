
begin
{
	function GetBuildType ([System.IO.DirectoryInfo] $d)
	{
		if ($d.parent.Name -eq "ENV.Config")
		{
			return $d.parent.parent
		}
		else
		{
			return GetBuildType $d.parent
		}
	}
}

process
{
	$dir = GetBuildType $_.Directory
	
	Write-Output $dir.Name
}

end{}

