param( [string] $key = $(throw 'The Unique Build key is required i.e. buildtype'),
	   [string] $environment = $(throw 'The test environment is required i.e. Assembly'),
	   [string] $newBuildNumber = $(throw 'The new build number is required'),
	   [string] $connectionString = $(throw 'A connection string is required'))
	   
function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 

function create-Query ([string] $teamBType, [string] $_env)
{
"SELECT     $_env
FROM        Deployments
WHERE     (TeamBuildType = '$teamBType')"
}


#Main#
#This script will get the rollback back build number of a deploymen to an environment
#It does this by querying the SRM Deployment database and parsing the xml  
# 
##

$conn = New-Object System.Data.SqlClient.SqlConnection 
$conn.connectionstring = $connectionString
$conn.Open() | out-null
$sqlcmd = New-Object System.Data.SqlClient.SqlCommand
$sqlcmd.Connection = $conn
$sqlcmd.commandtext = $(create-Query $key $environment)
$reader = $sqlcmd.ExecuteReader()

[string] $rollbackBuild = "NA"

while ($reader.Read())
{
	#query will only have one row with 1 field
	#this field is XML therefore need to intailize 
	#this field to xml 
	 
	if (!$reader.IsDBNull(0))
	{
		[xml] $xml = $reader.GetValue(0)
	}
}

#close all connections

$reader.close()
$reader.Dispose()
$sqlcmd.Dispose()
$conn.Close()
$conn.Dispose()


#if the xml variable is not set
#there was no db entry for the environment
#this means this is first deployment for the build type to this env
#And 'NA' will be returned

if (Get-Variable -Name xml -ea SilentlyContinue)
{
	$buildData = $xml.Environments.SelectSingleNode("Environment[@Name='$environment']").Builds.SelectSingleNode("Build[@TeamBuildType='$key']")

	if ($buildData)	
	{
		#Set to current build number in this environment 
		
		$rollbackBuild = $buildData.GetAttribute("BuildNumber")
		
		if ($newBuildNumber -eq $rollbackBuild)
		{
			# A redployment is being run (new configs would be a reason)
			#therefore keep rollback the same as is was 
			
			$rollbackBuild = $buildData.GetAttribute("RollBackBuild")
		}
	}
}


return $rollbackBuild 

#TST1 IS.StartRenewalConversion-1.0.0.3 IS.SRP.Release IntegratedServices.Projects IS.StartRenewalConversion-1.0.0.2 TFSBUILD 03/18/2008 13:20:27


