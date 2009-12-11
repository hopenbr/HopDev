param([string] $serverName = $(throw 'The Database server name is required'),
	  [string] $dbName = $(throw 'The Database name is required'),
	  [string] $connectionString = $(throw 'The Database connection string is required'),
	  [string] $path2bckupDir = $(Get-Location))


###MAIN###

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | out-null

if (!$(Test-Path $path2bckupDir))
{
	New-Item -ItemType directory -Name $(split-path $path2bckupDir -Leaf) -Path $(split-path $path2bckupDir -Parent) | out-null
}

$conn = New-Object System.Data.SqlClient.SqlConnection 
$conn.connectionstring = $connectionString
#$conn.Open() | out-null

$srv=New-Object "Microsoft.SqlServer.Management.Smo.Server" $serverName
$bck=new-object "Microsoft.SqlServer.Management.Smo.Backup"
$bck.Action = 'Database' 
$bckupFile=new-object "Microsoft.SqlServer.Management.Smo.BackupDeviceItem"
$bckupFile.DeviceType='File'
$bckupFile.Name= $(join-path $path2bckupDir ($dbName + ".bak"))
$bck.Devices.Add($bckupFile)
$bck.Database= $dbName
$bck.SqlBackup($srv)
