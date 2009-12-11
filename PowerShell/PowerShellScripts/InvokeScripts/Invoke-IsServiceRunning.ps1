###Invoke-IsServiceRunning

[string] $returnString = "True"

gwmi -query "select * from win32_service" -computer $serverName -ea silentlyContinue | 
	? {$_.Name -match "$matchString"} |
	% { if ($_.State -ne "Running"){$returnString = "False"}}


return $returnString