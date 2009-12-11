param(
[string] $cmd = $(throw 'SQL Insert cmd string is required' ),
[string] $connectionString = $( throw 'Database connection string is required'),
[string] $cmdType = $($null)
)

#param(
#[string] $insert = $("INSERT INTO DEPLOYMENTS_ASY (BuildNumber,TimeStamp,TeamBuildType,TeamProject) VALUES('NewNextBuild-1.1.0.4','04/07/2008','SRM','NewNextBuild.Release')"),
#[string] $connectionString = $( "server=AS73tfstst01;database=SRM_TFS_Deploys;trusted_connection=true;")
#)

$conn = New-Object System.Data.SqlClient.SqlConnection 
$conn.connectionstring = $connectionString
$conn.Open()
$sqlcmd = New-Object System.Data.SqlClient.SqlCommand
$sqlcmd.Connection = $conn
$sqlcmd.commandtext = $cmd
$sqlcmd.ExecuteNonQuery() | Out-Null
$conn.Close()