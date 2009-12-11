param($deployer = $(throw 'SRM TFS Deployer object is required'),
      [string] $rbb, 
      [datetime] $ts = $(Get-Date))

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 

function create-Xml ([string] $_env, [string] $_bn, [string] $_tbt, [string] $_tp, [datetime] $_ts, [string] $_rbb, [string] $_deployBy)
{
"<?xml version=`"1.0`" encoding=`"utf-8`"?>
<?xml-stylesheet type=`"text/xsl`" href=`"EnvironmentMapping.xsl`"?>
<Environments LastUpdated=`"$_ts`"  xmlns:xsi=`"http://tempuri.org/XMLSchema.xsd`"  xsi:noNamespaceSchemaLocation=`"SRMEnvironmentMappings.xsd`">
  <Environment Name=`"$_env`">
    <Builds>
      <Build TeamProject=`"$_tp`" TeamBuildType=`"$_tbt`" BuildNumber=`"$_bn`" TimeStamp=`"$_ts`" RollBackBuild=`"$_rbb`" DeployedBy=`"$_deployBy`" />
    </Builds>
  </Environment>
</Environments>"
}

function create-InsertQuery ([string] $_xml, [string] $e, [string] $teamBType, [string] $teamProj)
{
"declare @xml varchar(8000)
set @xml='$_xml'

INSERT INTO DEPLOYMENTS (TeamBuildType,TeamProject,$e) VALUES('$teamBType','$teamProj',@xml)"
}

function create-updateRowQuery ([string] $_xml, [string] $e, [string] $teamBType)
{
"declare @xml varchar(8000)
set @xml='$_xml'

UPDATE DEPLOYMENTS
SET $e = @xml
WHERE TeamBuildType = '$teamBType'"
}

function create-LookupQuery ([string] $teamBType)
{
"SELECT     TeamBuildType
FROM         Deployments
WHERE     (TeamBuildType = '$teamBType')"
}


###MAIN###

$script = get-script

Push-location $(split-path $script -parent)

#set Variables
[string] $env = $($deployer.RegionName.Name)
[string] $bn = $deployer.BuildData.BuildNumber
[string] $tbt = $deployer.BuildData.BuildType
[string] $tp = $deployer.BuildData.TeamProject
[string] $deployBy = $deployer.BuildData.LastChangedBy
[string] $connectionString = $deployer.config.Deployment.ConnectionString

$deployer.logger.log($("Starting Env Mapping DB update`nConnectionString: $connectionString"), "config")

[string] $cType = "INSERT"

[string] $xml = create-Xml $env $bn $tbt $tp $ts $rbb $deployBy

[string] $sqlcmd = create-InsertQuery $xml $env $tbt $tp

[string] $lookUp = create-LookupQuery $tbt

$deployer.logger.log($("Calling SQL: lookup`nCMD:`n$lookUp"), "debug")

if ($rbb -ne "NA" -or $(..\Check-SQLQuery4Rows.ps1 $lookUp $connectionString))
{
	$cType = "UPDATE"
	$sqlcmd = create-updateRowQuery $xml $env $tbt
}

$deployer.logger.log($("Calling SQL: $cType`nCMD:`n$sqlcmd"), "debug")

..\Run-SQLNonQuery.ps1 $sqlcmd $connectionString $cType

$deployer.logger.log($("Env Mapping DB update Complete"), "debug")

Pop-Location
