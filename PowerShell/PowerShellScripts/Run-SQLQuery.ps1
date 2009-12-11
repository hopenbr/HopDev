param(
[string] $cmd = $(throw 'SQL Insert cmd string is required' ),
[string] $connectionString = $( throw 'Database connection string is required')
)

$conn = New-Object System.Data.SqlClient.SqlConnection 
$conn.connectionstring = $connectionString
$conn.Open() | out-null
$sqlcmd = New-Object System.Data.SqlClient.SqlCommand
$sqlcmd.Connection = $conn
$sqlcmd.commandtext = $cmd
$reader = $sqlcmd.ExecuteReader()

return $reader