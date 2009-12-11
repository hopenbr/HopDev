##Create-Logger 
#This script will return a logger object that logs to event application
#log of the local host 

param([string] $eventSource = $(throw 'The Event log source is required'),
	  [string] $logID = $(throw 'The Event log ID is required'),
	  [string] $logLevel = $("Info"),
	  [string] $logOutput = $("Event"),
	  [string] $logFile = $("C:\LoggerOutput.log"))

function get-Admin 
{
	$ident = [Security.Principal.WindowsIdentity]::GetCurrent()

	foreach ( $groupIdent in $ident.Groups ) 
	{
	  if ( $groupIdent.IsValidTargetType([Security.Principal.SecurityIdentifier]) ) 
	  {
		   $groupSid = $groupIdent.Translate([Security.Principal.SecurityIdentifier])
		   if ( $groupSid.IsWellKnown("AccountAdministratorSid") -or $groupSid.IsWellKnown("BuiltinAdministratorsSid"))
		   {
				return $true
		   }
	  }
	}
	
	return $false
}

function get-OutputType 
{
	param([string] $output = $("Event"))
	
	#ensure that proper output type was passed in
	#else default to Event
	
	switch ($output) 
	{ 
		"Event" {} 
		"File" {} 
		"Both" {} 
		default {$output = "Event"}
	}
	
	return $output
}

###MAIN###

#ensure user is an admin on this box which allow him/her to log to App 
#Event log 
if ($logOutput -ne "File" -and $(Get-Admin) -eq $false)
{
	throw "User: ($env:username) is not authorized to write to Application Event log of ($env:computername)" 
}

$logger = new-object Object
	
$logger | Add-Member -MemberType NoteProperty -Name "Level" -Value $logLevel

$logger | Add-Member -MemberType NoteProperty -Name "EventSource" -Value $eventSource	

$logger | Add-Member -MemberType NoteProperty -Name "OutputType" -Value $(get-OutputType $logOutput)	

$logger | Add-Member -MemberType NoteProperty -Name "LogFile" -Value $logFile

$logger | Add-Member -MemberType NoteProperty -Name "ID" -Value $logID 

$logger | Add-Member -MemberType NoteProperty -Name "Output2Host" -Value $false 

[ScriptBlock] $eventLogger = { [string] $msg = $args[0]
[string] $msgLevel = $args[1]
[int] $id = $this.ID

if ($args.Count -eq 3) { $id = $args[2]}


	
[hashtable] $loglevel = @{"error" = 0;
						  "warning" = 1;
						  "info" = 2;
						  "config" = 3;
						  "debug" = 4}
						  
						  

if ($logLevel.ContainsKey($msglevel) -and
	$logLevel.ContainsKey($this.Level))
{
	$type = "Information"
	
	if ($msgLevel -eq "error")
	{
		$type = "Error"
	}
	elseif ($msgLevel -eq "warning")
	{
		$type = "Warning"
	}
							  
	if ($logLevel[$this.Level] -ge $logLevel[$msgLevel])
	{
		Write-Debug $msg
		
		Switch -regex ($this.OutputType)
		{
			"Event|Both" 
			{
				# Create the source, if it does not already exist.
				if(![System.Diagnostics.EventLog]::SourceExists($this.EventSource))
				{
					[System.Diagnostics.EventLog]::CreateEventSource($this.EventSource,'Application')
				}
				
				if ($msg.Length -gt 32766)
				{
					$msg = $msg.remove(32764)
				}	
			
				$log = New-Object System.Diagnostics.EventLog 
				$log.set_log("Application") 
				$log.set_source($this.EventSource)
				$log.WriteEntry($msg,$type,$id)
				
			}
			"File|Both" 
			{
				$logFile = $this.LogFile
				
				if (!(Test-Path $logFile))
				{
					$logFile = new-item -Path (split-path $logfile -Parent) -Name (split-path $logfile -Leaf) -ItemType file
					
					"Log Date: $(Get-Date)
Log Source: $($this.EventSource)
Logging Level: $($this.Level) 
Logging ID: $($this.ID)" | Out-File -FilePath $logFile -Append -Encoding ASCII
					
				}
				else
				{
					$logFile = Get-Item -Path $logFile
					
					if ($($logFile.length /1MB) -gt 50)
					{#log file is greater than 50 mb want to spin off new log file 
						Rename-Item -Path $logFile -NewName $($(split-path $logfile -leaf) -replace "\.", ("_" + $($(Get-Date).ToString("yyyyMMdd_hhmmss")) + "."))
						$logFile = new-item -Path (split-path $logfile -Parent) -Name (split-path $logfile -Leaf) -ItemType file
						"Log Date: $(Get-Date)
Log Source: $($this.EventSource)
Logging Level: $($this.Level) 
Logging ID: $($this.ID)" | Out-File -FilePath $logFile -Append -Encoding ASCII
						
					}
				}
				
				$(Get-Date).ToString("MM/dd/yyyy hh:mm:ss tt") + "  $msgLevel, $msg" | Out-File -Append -FilePath $logFile -Encoding ASCII
				
			}
		}
		
	}
}

} #end of script block

$logger | Add-Member -MemberType ScriptMethod -Name "Log" -Value $eventLogger

return $logger

