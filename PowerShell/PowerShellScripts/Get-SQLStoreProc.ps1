##Invoke-SQLStoredProc
#This script will run a store procedure
#it will return the number of rows touched by the SP 
	

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 

###MAIN###
[psobject] $isqlsp = New-Object Object

$isqlsp | Add-Member -MemberType NoteProperty -Value $(split-path $(get-script)) -Name "LocalScriptDir"

$isqlsp | Add-Member -MemberType NoteProperty -Value (0 -as [int]) -Name "RowsTouched"

$isqlsp | Add-Member -MemberType NoteProperty -Value ($null -as [System.IAsyncResult]) -Name "Result"

$isqlsp | Add-Member -MemberType NoteProperty -Value "" -Name "ConnectionString"

$isqlsp | Add-Member -MemberType NoteProperty -Value "" -Name "StoredProc"


[scriptblock] $exec = {
Push-Location $this.LocalScriptDir

#opening up SQL connection
$conn = New-Object System.Data.SqlClient.SqlConnection($this.ConnectionString)

#getting the sql commond object
$sqlcmd = New-Object System.Data.SqlClient.SqlCommand($this.StoredProc, $conn)

$conn.Open()

$this.Result = $sqlcmd.BeginExecuteNonQuery();

while (!$this.Result.IsCompleted)
{
	sleep -Seconds 10
}

$this.RowsTouched = $sqlcmd.EndExecuteNonQuery($this.Result)

$conn.Close()

popd

}

$isqlsp | Add-Member -MemberType ScriptMethod -Value $exec -Name "Exec"

return $isqlsp