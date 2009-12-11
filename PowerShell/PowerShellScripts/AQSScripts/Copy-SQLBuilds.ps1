pushd "\\us73starteam01\AQSBuilds\HRPA\Release"

$dest = get-item "\\ds73aqsdev02\E$\Install\AQS Advantage"

ls | ?{$_.Name -match "02.044.0" -and 
		(-not ($_.Name.Endswith("bad") -or 
			$_.Name.Endswith("Patch")))} |
				%{ copy $(Join-Path $_ "SQL") $(Join-Path $dest $($_.Name.split(" ")[2]))-Recurse}
				