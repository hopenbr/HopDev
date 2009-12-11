param(
[string] $dbServer = $(throw 'Database server name is required'),
[string] $dbName =  $(throw 'Database name is required'),
[string] $dbFileName =  $(throw 'Database file name is required'),
[string] $dbLogName =  $(throw 'Database log name is required'),
[string] $dbFilePath = $("C:\Data\"),
[string] $dbLogPath = $("C:\Data\")
)

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO")  | out-null

#Instantiate objects for the Server, the Database and the FileGroup
$s = new-object ('Microsoft.SqlServer.Management.Smo.Server') $dbServer
$db = new-object ('Microsoft.SqlServer.Management.Smo.Database') ($s, $dbName)
$fg = new-object ('Microsoft.SqlServer.Management.Smo.FileGroup') ($db, "PRIMARY")
#Add the filegroup to the database
$db.FileGroups.Add($fg) | out-null

#Instantiate the data file object and add it to the PRIMARY filegroup
$dbdfile = new-object ('Microsoft.SqlServer.Management.Smo.DataFile') ($fg, $dbFileName)
$fg.Files.Add($dbdfile)
#Set the properties of the data file
$dbdfile.FileName = $(Join-Path $dbFilePath $dbFileName) + ".mdf"
$dbdfile.Size = [double](.01 * 1024.0)
$dbdfile.GrowthType = "Percent"
$dbdfile.Growth = 25.0
$dbdfile.MaxSize = [double](1.0 * 1024.0)

#Instantiate the log file object and set its properties
$dblfile = new-object ('Microsoft.SqlServer.Management.Smo.LogFile') ($db, $dbLogName)
$dblfile.FileName = $(Join-Path $dbLogPath $dbLogName) + ".ldf"
$dblfile.Size = [double](.005 * 1024.0)
$dblfile.GrowthType = "Percent"
$dblfile.Growth = 25.0

#Create the database
$db.Create() | Out-Null
return $db