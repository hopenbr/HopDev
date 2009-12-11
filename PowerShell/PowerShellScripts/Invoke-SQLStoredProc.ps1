##Invoke-SQLStoredProc
#This script will run a store procedure
#it will return the number of rows touched by the SP 

param([string] $sp  = $(throw 'The full name of the Store processdure is required'),
	  [string] $connectionString = $(throw 'The connection string is required'),
	  [switch] $asynchronous)
	

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 

###MAIN###

void [System.Reflection.Assembly]::LoadWithPartialName("System.Data")

pushd $(split-path $(get-script))

$logger = .\Create-Logger.ps1 "HPP Invoke SQL" "4220"

$logger.log("Started HPP SQL Invoke SP", "info")

#opening up SQL connection
$conn = New-Object System.Data.SqlClient.SqlConnection($connectionString)

#getting the sql commond object
$sqlcmd = New-Object System.Data.SqlClient.SqlCommand

$sqlcmd.Connection = $conn
$sqlcmd.Commandtext = $sp
$sqlcmd.CommandType = [System.Data.CommandType]::StoredProcedure

$conn.Open()

[int] $rowsTouched = 0

if (-not $asynchronous)
{
	$rowsTouched = $sqlcmd.ExecuteNonQuery()
}
else
{
	$logger.log("Asynchronous exec started", "info")
	[System.IAsyncResult] $result = $sqlcmd.BeginExecuteNonQuery();
	
	[int] $count = 0
	[int] $totalCount = 0
	[int] $sleepTime = 1
	
	#wait until SP is is complete 
	while (!$result.IsCompleted)
	{
		$count++
		
		if ($count -ge 15)
		{
			$totalCount += $count 
			$count = 0
			
			if ($totalCount -lt 60) 
			{
				$sleepTime = 1;
				#wait 15 seconds
			}
			elseif ($totalCount -lt 300)
			{
				$sleepTime = 2
				#wait 30 seconds
			}
			elseif ($totalCount -lt 900)
			{
				$sleepTime = 4
				#wait 1 minute
			}
			elseif ($totalCount -lt 1800)
			{
				$sleepTime = 20
				#wait 5 minute
			}
			else
			{
				$sleepTime = 50
				#wait 15 minute
			}
			
			#logs only after wait time 
			#will break if sp finishes during wait time
			#sleeptime is check time
			$logger.log("waiting for Stored Proc to finish `(Next wait-time: $($sleepTime * 15) seconds`)", "info")
			#Write-Host "Waiting for SP to finish `(Next wait-time: $($sleepTime * 15) seconds`)"
			
		}
		
		sleep -Seconds $sleepTime
	}
	
	$rowsTouched = $sqlcmd.EndExecuteNonQuery($result)

}

$conn.Close()

popd

$logger.log("HPP SQL Invoke SP touched $rowsTouched rows", "info")

return $rowTouched
