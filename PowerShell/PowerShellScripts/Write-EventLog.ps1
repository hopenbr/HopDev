param ([string]$msg = $(throw "Required parameter cannot be null: an Event Description"), 
	   [string]$source = $(throw "Required parameter cannot be null: Event Source"), 
	   [int]$eventid = $(throw "Required parameter cannot be null: EventID"),
	   [string]$type = $("Information"))

#Check if user is admin
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

function write-EventLog
{ 
# Create the source, if it does not already exist.
	if(![System.Diagnostics.EventLog]::SourceExists($source))
	{
		[System.Diagnostics.EventLog]::CreateEventSource($source,'Application')
	}
	        
	# Check if Event Type is correct
	# if not default it to Info
	switch ($type) 
	{ 
		"Information" {} 
		"Warning" {} 
		"Error" {} 
		default {$type = "Information"}
	}
	
	if ($msg.Length -gt 32766)
	{
		$msg = $msg.remove(32764)
	}	
	      
	$log = New-Object System.Diagnostics.EventLog 
	$log.set_log("Application") 
	$log.set_source($source)
	$log.WriteEntry($msg,$type,$eventid)
}

#MAIN#

$Result = get-Admin

if ($Result -eq $False) 
{
	throw "Better be an admin for this script."
	#exit
}
write-debug "Eventlog: $msg"
Write-Eventlog
write-debug "Eventlog: Write Completed"
