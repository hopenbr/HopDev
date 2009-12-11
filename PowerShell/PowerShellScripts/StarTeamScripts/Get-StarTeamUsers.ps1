#Get-StarTeamUserInfo
#This script reads a starteam security log that needs to exported via the
#starteam serverr on the server
#the info exported to a CSV file that call be imported in Excel for further 
#reporting

param ([string] $log = $(throw 'The Full UNC path to the Starteam server log is required'),
       [string] $outputPath = $("C:\UserInfo.csv"),
	   [switch] $ReturnUserInfo)

function get-AvgLoginTime ()
{
[scriptblock] $sb = { [long] $totalTime = 0
Foreach ($t in $this.LoginTimes)
{
	$totalTime += $t.TotalSeconds
}

$avg = 0

if ($this.LoginTimes.Count -gt 0) 
{
	$avg = $($totalTime/$This.LoginTimes.Count)
}

return $(New-TimeSpan -Seconds $avg)

} #end ScriptBlock

return $sb
}

function get-LongestTime ()
{
	[scriptblock] $sb = {
	if ($this.LoginTimes.Count -eq 0)
	{
		new-timespan -Seconds 0
	}
	elseif ($this.LoginTimes.Count -eq 1)
	{
		$this.LoginTimes[0]
	}
	else
	{
		$($this.LoginTimes | sort -Descending)[0]
	}
	
} #end sb

return $sb
}

function get-ShortestTime ()
{
	[scriptblock] $sb = {
	if ($this.LoginTimes.Count -eq 0)
	{
		new-timespan -Seconds 0
	}
	elseif ($this.LoginTimes.Count -eq 1)
	{
		$this.LoginTimes[0]
	}
	else
	{
		$($this.LoginTimes | sort )[0]
	}
	
} #end sb

return $sb
}

function new-UserLoginInfo([string] $name)
{
	$loginInfo = New-Object PSObject 
	
	$loginInfo | Add-Member -MemberType NoteProperty -Name "Name" -Value $name
	
	$loginInfo | Add-Member -MemberType NoteProperty -Name "Logins" -Value $([int] 0)
	
	$loginInfo | Add-Member -MemberType NoteProperty -Name "LoginTimes" -Value $(new-object System.Collections.ArrayList)
	
	$loginInfo | Add-Member -MemberType ScriptMethod -Name "AvgLoginTime" -Value $(get-AvgLoginTime)
	
	$loginInfo | Add-Member -MemberType ScriptMethod -Name "LongestLoginTime" -Value $(get-LongestTime)
	
	$loginInfo | Add-Member -MemberType ScriptMethod -Name "ShortestLoginTime" -Value $(get-ShortestTime)
	
	$loginInfo | Add-Member -MemberType ScriptMethod -Name "NumberOfLogins" -Value {$this.LoginTimes.Count}
	
	return $loginInfo
}


###MAIN###
$logs = gc $log

$users = $logs | 
	?{ $_ -match "User .+? logged on"} |
		%{
			$_ -match "User (.+?) logged on" | 
				out-null; $matches[1] 
		 } | sort | get-unique
			
			
[regex] $rxDateStamp = "(2009-.+?)\s\s"
[regex] $rxCID = "CID:(\d+)"
$userInfo = new-object System.Collections.ArrayList

foreach ($user in $users)
{
	$lu = New-UserLoginInfo $user
	
	$logs | 
		?{$_ -match "User $user logged on"} |
		%{
			$lu.Logins++
			[string] $baseTime = "1900-01-01 16:20:00"
			[DateTime] $start = $rxDateStamp.Match($_).groups[1].value
			[DateTime] $end = $baseTime
			[string] $cid = $rxCID.Match($_).groups[1].value
			
			$logOffLine = ""
			
			foreach ($l in $logs)
			{
				if (($l -match "logged off" -or
					 $l -match " lost ") -and 
					 $l -match $cid)
				{
					$logOffLine = $l
					break
				}
			}
			
			if ($logOffLine)
			{			
				$end = $rxDateStamp.Match($logOffLine).Groups[1].value
			}
			
			if ($end -ne $baseTime)
			{
				$lu.LoginTimes.Add($(New-TimeSpan -Start $start -End $end)) | Out-Null
			}
			
		}
		
		
	$userInfo.Add($lu) | Out-Null	
	
}
if ($ReturnUserInfo)
{
	return $userInfo
}
else
{
	$sb = new-object System.Text.StringBuilder
	
	$sb.AppendLine("Name,Logins,TimedLogins,AvgLogin,Long,short") | Out-Null
	
	foreach ($ui in $userInfo)
	{
		$sb.AppendLine($ui.Name + "," + 
					$ui.Logins + "," +
					$ui.NumberofLogins() + "," +
					$ui.AvgLoginTime() + "," +
					$ui.LongestLoginTime() + "," + 
					$ui.ShortestLogintime()) | Out-Null
	}
	
	$sb.ToString() | out-file -FilePath $outputPath
	

	return $(get-item $outputPath)
}
