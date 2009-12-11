param([string] $testXmlPath = $( .\TfsEventServicesTestData.xml),
	  $wi = $null)
 
trap 
{
	return $wi
}
 
function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

function save-WorkItem ($_wItem)
{
	if ($_wItem.IsValid())
	{
		write-log "Saving workitem"
		 $_wItem.Save()
		 Start-sleep -seconds 5 
	}
	else
	{
		 write-log "WorkItem Not Validate" "Error" 
		 #$_wItem.Validate()
	}
	
	return $_wItem
}

function write-log ([string] $_log, [string] $_type)
{
	switch ($_type)
	{
		"Warning"
		{
			write-warning $_log
		}
		"Error" 
		{ 
			write-error $_log
		}
		Default
		{ 
			write-host $_log
		}
	}
	
	write-output $("`n" + $_log) >> $("TfsEventServicesTest_" + $today.ToString("yyyyMMddhhmm") + ".log")
}

function create-WorkItem ($fields)
{
	write-log "Creating workitem..." 
	$dbi = .\Create-WorkItem.ps1 
	
	write-log $("Workitem # " + $dbi.ID.ToString() + " created")
	
	$dbi = change-Fields $dbi $fields
	
	$dbi = save-WorkItem $dbi
	
	return $dbi
	
}

function change-Fields ($_dbi, $fields)
{
	write-log "Staring field updates"
	 
	foreach ($field in $fields.Field)
	{
		$value = replace-FieldValues $field.GetAttribute("value")
		$name = $field.GetAttribute("name")
		write-log $("Setting fields `'" + $name + "`' to ``" + $value + "`'")
		$_dbi.Fields[$name].value = $value
		
		if (!$_dbi.Fields[$name].IsValid)
		{
			write-log "WARNING: Not Valid"
		} 
				
	}
	
	write-log "Field updates complete"
	return $_dbi
}

function check-4Latest ($_wi)
{
	[int] $rev = $_wi.Rev
	write-log "Checking for backend updates"
	do
	{
		Start-Sleep -seconds $sleepTime
		write-log "Sync to latest"
		$_wi.SyncToLatest()
		
	}until ( $_wi.Rev -gt $rev)
	
	write-log "New rev synced, waiting to allow backend to complete close out"
	Start-Sleep -seconds 15
	
	return $_wi
}

function replace-FieldValues ([string] $_val)
{
	$regex = [regex] "\[\w+?\]"
	
	switch ($regex.Match($_val).Value)
	{
	        "[TODAY]"
		{
		  	$_val = $_val.Replace("[TODAY]", $today.ToShortDateString())
		  	break
		}
		
		"[TEST]"
		{
		  	$_val = $_val.Replace("[TEST]", $("Test (" + $today.ToShortDateString() + ") " ))
		  	break
		}
		"[USERNAME]"
		{
			$_val = $_val.Replace("[USERNAME]", ${env:username})
		  	break
		}
		"[ID]"
		{
			$_val = $_val.Replace("[ID]", $wiId.ToString())
		  	break
		}
		"[NOTNULL]"
		{
			$_val = $null
		  	break
		}
		"[RSTRING]"
		{
			$_val = $_val.Replace("[RSTRING]", $(create-RandomString 10))
		  	break
		}
		"[RSTRINGLONG]"
		{
			$_val = $_val.Replace("[RSTRINGLONG]", $(create-RandomString 100))
		  	break
		}
	}
	
	return $_val
}

function create-RandomString ([int] $length)
{
	$rand = New-Object System.Random
	[string] $rstr = ""
	1..$length | ForEach { $rstr = $rstr + [char]$rand.next(65,90) }
	return $rstr
	
}

function verify-Fields ($_wi, $vFields)
{
	write-log "Staring workitem verification"
	foreach ($field in $vFields.Field)
	{
		
		$val = replace-FieldValues $field.GetAttribute("value")
		$name = $field.GetAttribute("name")
		[string] $realVal = $_wi.Fields[$name].Value
		
		write-log $("`nVerify " + $name + " value is set to " + $val )
		
		if (!$realVal.Equals($val))
		{
			if ($val -ne "") 
			{
				switch ($field.erroraction) 
				{
					"Ignore" { break }
					"Warn" 
					{
						 write-log $("Field mismatch: " + $name + "( " + $_wi.Fields[$name].Value + " != " + $val + " )") "Warning"
						 break
					}
					Default
					{
						 write-log $("Field mismatch: " + $name + "( " + $_wi.Fields[$name].Value + " != " + $val + " )") "Error"
						 throw $_wi
					}
				}
			}
			else
			{
				write-log $("Test passed`nField: " + $name + "`nIs not null" ) "host"
			}
		}
		elseif ($val -eq "" -and $realVal.Equals($val)) 
		{
			throw $("Null Field: " + $name + " cannot be null")	
		}
		else
		{
			write-log $("Test passed`nField: " + $name + "`nEquals: " + $val )
		}
	}
	
	write-log "Verification complete"
	
}

function cycle-WorkItem ($_wi, $cycles)
{
	write-log "*** Strating life cycle moves ***"
	
	foreach ($cycle in $cycles.Cycle)
	{
		write-log $("*** Cycle: " + $cycle.GetAttribute("name"))
		
		$_wi = change-Fields $_wi $cycle.Fields
		$_wi = save-WorkItem $_wi
		
		if ($_wi.IsValid)
		{
			$_wi = check-4Latest $_wi
			verify-Fields $_wi $cycle.Verify.Fields
		}
	}
	
	write-log "***Life cycle complete***"
	
	return $_wi
}


$script = get-script
$script_folder = split-path $script
Push-Location $script_folder

$testXml = [xml] (Get-Content $testXmlPath)
[int] $wiId = 0
[int] $count = 0
[int] $sleepTime = 5
$testWorkItems = @{}
$today = get-date

foreach ($test in $testXml.TfsEventServicesTestData.Tests.Test)
{
	write-log "***Starting test***"
	
	if ($test.GetAttribute("sleeptime"))
	{
		$sleepTime = $test.GetAttribute("sleeptime")
		write-log $("New Sleep time set to: " + $sleepTime.ToString() + " seconds")
	}
	else
	{
		$sleepTime = 5
	}
	
	if (!$wi -or $count -gt 0 )
	{
		$wi = create-WorkItem $test.Create.Fields
		
		if ($wi.IsValid)
		{
			$wi = check-4Latest $wi
		}
		else
		{
			write-log "Error; returning workitem"
			return $wi
		}
	}
	
	$wiId = $wi.ID
	verify-Fields $wi $test.Create.Verify.Fields
	$wi = cycle-WorkItem $wi $test.LifeCycle
	
	if ($wi.IsValid)
	{
	
		write-log $("Test complete workitemed created: " + $wi.ID.ToString()) 
		$count++
		$testWorkItems.Add($test.GetAttribute("name"), $wi)
		$wi = $null
	}
	else
	{
		write-log "Error: returning invalid workitem"
		return $wi
	}
	
}

foreach ($twi in $testWorkItems.Values)
{
	$twi.SyncToLatest()
}

return $testWorkItems