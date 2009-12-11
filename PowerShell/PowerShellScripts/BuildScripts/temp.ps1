$tfs.vcs.GetAllTeamProjects($true) | Select ServerItem | ?{$tfs.vcs.ServerItemExists($_.ServerItem + "/T
eamBuildTypes", $folderType)} | %{ $ws.map(($_.ServerItem + "/TeamBuildTypes"), (Join-Path "E:\Searcher"  $(split-path $_
.ServerItem -leaf))) }


$files = ls -recurse | ?{$_.Name -match "In-PrePrd"} | %{ls $_.FullName -recurse } | ?{-not $_.Mode.contains("d")} | %{$(gc $_.Fullname) -match "5555"}


ls -recurse | 
	?{$_.Name -match "In-PrePrd"} | 
		%{ls $_.FullName -recurse } | 
			?{-not $_.Mode.contains("d")} | 
				%{				
					[regex] $rx = '=\"http://([a|e].+?\:5555)'
					
					if ($rx.match($(gc $_.Fullname)).groups[1].value)
					{
						$rx.match($(gc $_.Fullname)).groups[1]
					}
				}


function Get-Path2DeploymentConfig ([string] $p)
{
	$s = $p.split("\\")
	[string] $pdc = $s[0] + "\" + $s[1] + "\" + $s[2] +"\" + $s[3] + "\Deployment\DeploymentConfig.xml"
	
	return $pdc
}


[hashtable] $srnTable = @{"as73esbpre01:5555" = "ewspre";
			  "ewspre.harleysvillegroup.com:5555" = "ewspre";
		          "ewspre:5555" = "ewspre"}


foreach ($p in (gc E:\predc.txt))
{

	[xml] $xml = [xml] ($(gc $p) -replace "xmlns=`".*?`"", "")

	$xml.settings.packages.package.DeploymentRegions.selectsinglenode("DeploymentRegion[@Name='PrePrd']").RegionLocations.location | 
		%{
			(Join-Path $_.Path "*.config") | out-file -append -filepath E:\preConfigSearch.txt
		}
}

$files = $xvp.VisualStudioProject.VisualBasic.Files.include.file | ?{$_.BuildAction -eq "Content"} | %{$_.RelPath }


$files | 
	%{
		[string] $from = $(Join-Path "." $_)
		[string] $to = $(Join-Path "..\compiled" $_)
		
		if (-not (test-Path (Split-Path $to -Parent)))
		{
			[string] $p = Split-Path $to -Parent
			
			New-Item -Path (Split-Path $p -Parent) -Name (Split-Path $p -Leaf) -ItemType Directory -Force | Out-Null
			
		}
		
		copy -Path $from -Destination $to
		
	}
						 