
param($ws = $(throw 'The workspace is requred'))

begin
{
#	[hashtable] $serverReplacements = @{"PERFORMANCE" = "DEVELOPMENT";
#										"PF_DEV02" = "INTEGRATION";
#										"LGBP\.Projects" = "Life.Projects"}
										
	[hashtable] $serverReplacements = @{"Branches/INTEGRATION" = "Branches/INTEGRATION/LGBP";
										"Branches/DEVELOPMENT" = "Branches/DEVELOPMENT/LGBP"}
	
	
}

process
{
	#cd $_.Directory.Fullname
	
	#$ws.pendEdit($_)
	
	[xml] $xws
	
	if ($_.Name -eq "WorkspaceMapping.xml")
	{
		$xws = [xml] (gc $_.FullName)
		
		foreach ($imap in $xws.SerializedWorkspace.Mappings.InternalMapping)
		{
			foreach ($key in $serverReplacements.keys)
			{
				$imap.ServerItem = $imap.ServerItem -replace $key, $serverReplacements[$key]
			}
		}
	}
	else
	{
		$str =  (gc $_.FullName)
		
		foreach ($key in $serverReplacements.keys)
		{
			$str = $str -replace $key, $serverReplacements[$key]
		}
		
		$xws = [xml] $str
	}
	
	
	$xws.save($_.FullName)
	
}


end
{}