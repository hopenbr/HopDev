
#param([string] $connectionString = $("server=AS73tfstst01;database=SRM_TFS_Deploys;trusted_connection=true;"), 
#	   [string] $reportOutputPath = $("C:\DeploymentReport.html"),
#	   [int] $recentDeployDays = $(5),
#	   [int] $newDeployDays = $(1))

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else{ $myInvocation.MyCommand.Definition }
} 

function split-BuildNumber ($_build)
{

	[string] $bn = $_build.GetAttribute("BuildNumber")
	$regex = [regex] "[-_][\d+?\.]+"
	$array = @()
	
	#write-host $("Build Number: " + $bn)
	
	if ($regex.IsMatch($bn))
	{
		$array = $($regex.Split($bn) | Out-String), $regex.Match($bn).Value
	}
	else
	{
		$array = $bn, $bn
	}
	
	return $array
	
}

function get-Style ()
{
"<style type=`"text/css`">
<!-- 
.recentdeploy {
	margin: 5px 5px 5px -25px;
	border-style: solid;
	border-width: 1px;
	padding: 4px;
	font-family: Arial, Helvetica, sans-serif;
	background-color: #C0C0C0;
	font-size: medium;
	font-weight: bold;
	font-style: normal;
	font-variant: normal;
	text-decoration: none;
	list-style-type: none;
	text-align: left;
	}
.base{
	margin: 5px 5px 5px -25px;
	border-style: solid;
	border-width: 1px;
	padding: 4px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: small;
	font-weight: normal;
	font-style: normal;
	font-variant: normal;
	text-decoration: none;
	list-style-type: none;
	text-align: left;
	}
.newdeploy {
	margin: 5px 5px 5px -25px;
	border-style: solid;
	border-width: 1px;
	padding: 4px;
	font-family: Arial, Helvetica, sans-serif;
	background-color: #FFFFCC;
	font-size: medium;
	font-weight: bold;
	font-style: normal;
	font-variant: normal;
	text-decoration: none;
	list-style-type: none;
	text-align: left;
	}
.oldbuild {
	margin: 5px 5px 5px -25px;
	border-style: solid;
	border-width: 1px;
	padding: 4px;
	font-family: Arial, Helvetica, sans-serif;
	background-color: #990000;
	font-size: medium;
	font-weight: bold;
	font-style: normal;
	font-variant: normal;
	text-decoration: none;
	list-style-type: none;
	text-align: left;
	color: white
	}
.extremelyold {
	margin: 5px 5px 5px -25px;
	border-style: solid;
	border-width: 1px;
	padding: 4px;
	font-family: Arial, Helvetica, sans-serif;
	background-color: #FF0000;
	font-size: medium;
	font-weight: bold;
	font-style: normal;
	font-variant: normal;
	text-decoration: none;
	list-style-type: none;
	text-align: left;
	color: yellow
	}
.outdatedbuildprd {
	margin: 5px 5px 5px -25px;
	border-style: solid;
	border-width: 1px;
	padding: 4px;
	font-family: Arial, Helvetica, sans-serif;
	background-color: #FF0000;
	font-size: medium;
	font-weight: bold;
	font-style: normal;
	font-variant: normal;
	text-decoration: none;
	list-style-type: none;
	text-align: left;
	color: white
	}
-->
</style>"
}

function get-buildInfoLink ([string] $_buildnum, [string] $time, [string] $rollback)
{
"$_buildnum"
}

function get-wMpackage ([string] $_tp, [string] $_bn)
{
	#$tfs is a script global variable 
	
	$uri = $tfs.tbp.GetBuildUri($_tp, $_bn)
	$bd = $tfs.tbp.GetBuildDetails($uri)
	
	return $(Join-path $bd.DropLocation "WmPackages") -replace "\\", "\\"

}

function create-BuildRow ([hashtable] $bh)
{
	$br = new-object System.Text.StringBuilder
	[hashtable] $brh = @{}
	[string] $_name = ""
	
	foreach ($k in $bh.keys)
	{
		if ($k -eq "name")
		{
			continue
		}
		
		#Write-Host $("Build Key: " + $k)
		
		$td = New-Object System.Text.StringBuilder 
		[hashtable] $_classHash = get-Class $bh  
		
		if ($bh[$k].GetAttribute("TeamBuildType"))
		{
			$_name, $bnum = split-BuildNumber $bh[$k]
			[string] $ts = $bh[$k].GetAttribute("TimeStamp")
			[string] $rb = $bh[$k].GetAttribute("RollBackBuild")
			[string] $tp = $bh[$k].GetAttribute("TeamProject")
			[string] $bn = $bh[$k].GetAttribute("BuildNumber")
			
			if ($tp -eq "WmProjects")
			{
				$c = $td.Append("<td onDblClick=`"window.open(`'$(get-wMpackage $tp $bn)`')`"" + $($_classHash[$k] | Out-String).TrimEnd() + ">" + $($bnum -replace '-', '') + "</td>")
			}
			else
			{
				$c = $td.Append("<td onDblClick=`"window.alert(`'Deployment Timestamp: $ts\nRollback build: $rb`')`"" + $($_classHash[$k] | Out-String).TrimEnd() + ">" + $($bnum -replace '-', '') + "</td>")
			}
		}
		else
		{
			$c = $td.Append("<td>na</td>")
		}
		
		$brh.add($k, $td.ToString())
		
		
	} # end foreach $k
	
	
	$c = $br.AppendLine("`n<!--BuildRow-->`n<tr><th align=left>$($bh.name | out-string)</th> $($brh.Assembly | Out-String) $($brh.QA2 | Out-String) $($brh.End2End | Out-String) $($brh.Training | Out-String) $($brh.PrePrd | Out-String) $($brh.Production | Out-String) $($brh.TST1 | Out-String)</tr>")
	
	return $br.ToString()
	
}

function get-Class ([hashtable] $_bh)
{
	[hashtable] $classHash = @{}
	
	foreach ($_e in $_bh.keys)
	{
		if ($_e -eq "name")
		{
			continue
		}
		
		[string] $parent = ""
		
		if ($_bh[$_e].GetAttribute("TeamBuildType"))
		{
			[string] $parent = get-ParentEnv($_e)
			[bool] $isOlderPrd = $false
			[bool] $isOlderParent = $false
			
			if ($($bh[$_e].GetAttribute("TimeStamp")) -and 
			    $(is-Within $newDeployDays $bh[$_e].GetAttribute("TimeStamp")))
			{
				$classHash.Add($_e, " class=newdeploy")
				
			}
			elseif ($($bh[$_e].GetAttribute("TimeStamp")) -and 
			    $(is-Within $recentDeployDays $bh[$_e].GetAttribute("TimeStamp")))
			{
				$classHash.Add($_e, " class=recentdeploy")
			}
			else
			{
				if ($_bh[$parent])
				{
					if ($_bh[$_e].GetAttribute("BuildNumber") -lt $_bh[$parent].GetAttribute("BuildNumber"))
					{
						$isOlderParent = $true
					}
					else
					{
						$isOlderParent = $false
					}
				}
				
				if ($_bh["Production"] -and $_e -ne "TST1")
				{
					if ($_bh[$_e].GetAttribute("BuildNumber") -lt $_bh["Production"].GetAttribute("BuildNumber"))
					{
						$isOlderPrd = $true
					}
					else
					{
						$isOlderPrd = $false
					}
				}
				
				if ($isOlderParent -and !$isOlderPrd)
				{
					$classHash.add($_e, " Class=oldbuild")
				}
				elseif ($isOlderPrd -and !$isOlderParent)
				{
					$classHash.Add($_e, " Class=outdatedbuildprd")
				}
				elseif ($isOlderPrd -and $isOlderParent)
				{
					$classHash.Add($_e, " Class=extremelyold")
				}
				else
				{
					$classHash.Add($_e, " Class=base")
				}
			}	
		}
		else
		{
			$classHash.add($_e, "")
		}
	}
	
	return $classHash
}

function get-ParentEnv ([string] $_e)
{
	switch ($_e)
	{
		"Assembly"
		{
			return "QA2"
			
		}
		"QA2"
		{
			return "End2End"
		}
		"End2End"
		{
			return "PrePrd"
			
		}
		"Training"
		{
			return "Production"
		}
		"PrePrd"
		{
			return "Production"
		}
		"Production"
		{
			return "Production"
		}
		"TST1"
		{
			return "TST1"
		}
		Default
		{
			return ($_e)
		}
	}# end switch
}


function get-BuildNode ([string] $env, [string] $key, $x)
{
	return ($x.Environments.SelectSingleNode("Environment[@Name='" + $env + "']").Builds.SelectSingleNode("Build[@TeamBuildType='" + $key + "']"))
}


function is-Within([int]$days, [datetime]$Date)
{
    [DateTime]::Now.AddDays(-$days).Date -le $Date.Date
}

function create-ReportHeader([datetime] $lastUpdate)
{
"
<!--Report Header Started-->

<table>
<tr>
<td colspan=4>
<h1>SRM Deployment Report</h2>
</td>
</tr>
<tr>
<td colspan=4>
<h2>Last updated: $lastUpdate</h2>
</td>
</tr>
<tr>
<td>
Key: 
</td>
</tr>
<tr>
<td>
<table border=1>
<tr>
<td>
<table>
<tr>
<td>Build is out dated: </td>
<td class=outdatedbuildprd>
compared to PRD
</td>
<td class=oldbuild>
compared to its parent
<td class=extremelyold>
compared to PRD and its parent
</td>
</tr>
<tr>
<td>Recent deployment: </td>
<td class=newdeploy>
Within last $($newDeployDays * 24) hours
</td>
<td class=recentdeploy>
Within last $recentDeployDays days
</td>
<td class=base>
Older than $recentDeployDays days
</td>
</tr>
</table>
</td>
</tr>
</table>
<table>
<tr>
<td>
<br>
</td>
</tr>
<tr>
<td clase=base>
This report only reflects deployments via TFS deployer and no others
</td>
</tr>
<tr>
<td clase=base>
Data collection stated on Oct, 2007
</td>
</tr>
<tr>
<td clase=base>
Click on build number for more information
</td>
</tr>
<tr>
<td>
<br>
</td>
</tr>
</table>
</td>
</tr>
</table>

<!-- Report Header End -->
"
}

function get-TeamProjects ($conn)
{
    [collections.arraylist] $tp =[collections.arraylist]@() 

	$sqlcmd = New-Object System.Data.SqlClient.SqlCommand
	$sqlcmd.Connection = $conn
	$sqlcmd.commandtext = "SELECT * FROM TeamProjects"
	$reader = $sqlcmd.ExecuteReader()
	
	while ($reader.read())
	{
		$tp.add($reader.GetValue(0)) | Out-Null
	}
	
	$reader.Close()
	$reader.Dispose()
	
	return $tp
	
}

function get-AccessHarleysvilleView ($conn)
{
	#Hashtable AccessHarleysville 
	#this will be main hash 
	#Its value will hold an array collection of hash tables that hold 
	#rows of deployment build package types for each team project
	
    [HashTable] $ah =[hashtable]@{} 

	$sqlcmd = New-Object System.Data.SqlClient.SqlCommand
	$sqlcmd.Connection = $conn
	$sqlcmd.commandtext = "SELECT * FROM Deployments"
	$reader = $sqlcmd.ExecuteReader()
	
	while ($reader.read())
	{
		[hashtable] $row = [hashtable] @{}
		
		#Here were are create the inner hash 
		#the holds deployment info about one
		#Team build type 
		for ([int]$i =0;$i -lt $reader.FieldCount;$i++)
		{
			$name = $reader.GetName($i)
			$val = $reader.GetValue($i)
			
			if ($name -eq "TeamProject" -or $name -eq "TeamBuildType")
			{
				$row.Add($name, $val) | Out-Null
			}
			else
			{
				if ($val.Length -gt 0)
				{
					if ($name -eq "Staging")
					{
						Write-Debug "Stage"
					}
					
					$row.Add($name, $([xml] $val)) | Out-Null
				}
				else
				{
					$row.Add($name, $(new-object System.XML.XmlDocument)) | Out-Null
				}
			}
		}
		
		if (!$ah.ContainsKey($Row.TeamProject))
		{
			$ah.add($row.TeamProject, [Collections.ArrayList]@()) | Out-Null
		}
		
		$ah[$row.TeamProject].Add($row) | Out-Null
	}
	
	$reader.Close()
	$reader.Dispose()
	
	return $ah
	
}

function get-TeamBuildTypes ($conn, [string] $teamProject)
{
    [collections.arraylist] $tb =[collections.arraylist]@() 

	$sqlcmd = New-Object System.Data.SqlClient.SqlCommand
	$sqlcmd.Connection = $conn
	$sqlcmd.commandtext = "SELECT TeamBuildType FROM TeamBuildTypes WHERE (TeamProject = '$teamProject')"
	$reader = $sqlcmd.ExecuteReader()
	
	while ($reader.read())
	{
		$tb.add($reader.GetValue(0)) | Out-Null
	}
	
	$reader.Close()
	$reader.Dispose()
	
	return $tb
	
}

function compare-deploymentTypes ([hashtable] $dType, [hashtable] $bHash)
{
	foreach ($r in $bHash.Keys)
	{
		if ($r -eq "name") {continue}
		
		#xmlNode
		$x1 = $dtype[$bHash["name"]][$r]
		$x2 = $bHash[$r]
		
		if ($x1.GetAttribute("TimeStamp").Length -gt 0 -and $x2.GetAttribute("TimeStamp").Length -gt 0)
		{
			[datetime] $current = $x1.GetAttribute("TimeStamp")
			[datetime] $new = $x2.GetAttribute("TimeStamp")
			
			if ($current -lt $new)
			{
				$dtype[$bHash["name"]][$r] = $bHash[$r] 
			}
		}
		elseif ($x1.GetAttribute("TimeStamp").Length -eq 0 -and $x2.GetAttribute("TimeStamp").Length -gt 0)
		{
			$dtype[$bHash["name"]][$r] = $bHash[$r]
		}
		
	}
	
	return $dtype
}

###MAIN###

#load SQL assembly
[system.reflection.assembly]::LoadWithPartialName("System.Data") | Out-Null

$script = ""
[string] $cpath = ""

if ($debug -eq $false)
{
	$script = get-script
	$script_folder = split-path $script
	Push-Location $script_folder
	[System.IO.FileInfo] $scriptFile = Get-Item $script
    $cpath = $sciptFile.fullname -replace $scriptFile.extension, ".config"
}
else
{
	#need this b/c when running in Debug mode in PowerGUI something don't work 
	
	$script = "C:\TFSWorkspaces\VS2008\SRM\Branches\DEVELOPMENT\Powershell\PowerShellScripts\TFSDeployerScripts\Create-DeploymentReport.ps1"
	$cpath = "C:\TFSWorkspaces\VS2008\SRM\Branches\DEVELOPMENT\Powershell\PowerShellScripts\TFSDeployerScripts\Create-DeploymentReport.config"
	pushd "C:\TFSWorkspaces\VS2008\SRM\Branches\DEVELOPMENT\PowerShell\PowerShellScripts\TFSDeployerScripts"
}


[xml] $config = [xml] $(gc $cpath)

[string] $connectionString = $config.configuration.appSettings.SelectSingleNode("add[@key='ConnectionString']").value
[string] $reportOutputPath = $config.configuration.appSettings.SelectSingleNode("add[@key='OutputPath']").value
[int] $recentDeployDays = $config.configuration.appSettings.SelectSingleNode("add[@key='RecentDeploymentDays']").value
[int] $newDeployDays = $config.configuration.appSettings.SelectSingleNode("add[@key='NewDeploymentDays']").value

$tfs = ..\get-tfs.ps1 

#open connection to Database
$conn = New-Object System.Data.SqlClient.SqlConnection 
$conn.connectionstring = $connectionString
$conn.Open() | out-null

$sb = new-object System.Text.StringBuilder

[hashtable] $tpHash = @{}
$environments = @($($config.configuration.appSettings.SelectSingleNode("add[@key='Environments']").value).Split(",")) 

#return a hash of arrays of hashes 
#Hash
#-TeamProjects (Array)
#--Team Build type (hash)
#---deployment table
$tphash = get-AccessHarleysvilleView $conn

$envHeader = new-object System.Text.StringBuilder

$envHeader.AppendLine("<TR BGCOLOR=GRAY BORDERCOLOR=BLACK><TH ALIGN=LEFT>Build name</TH>") | Out-Null

foreach ($e in $environments)
{
	if ($e -match "Dev" -or $e -eq "IRB")
	{
		continue
	}
	
	$envHeader.AppendLine("<TH>" + $e + "</TH>") | Out-Null
}

$envHeader.AppendLine("</TR>") | Out-Null

$sb.AppendLine("<HTML>") | Out-Null
$sb.AppendLine("<HEAD>") | Out-Null
$sb.AppendLine("<TITLE>SRM Deployment Report</TITLE>") | Out-Null
$sb.AppendLine($(get-Style)) | Out-Null
$sb.AppendLine("</HEAD>") | Out-Null
$sb.AppendLine("<BODY>") | Out-Null
$sb.AppendLine($(create-ReportHeader $(Get-Date))) | Out-Null
$sb.AppendLine("<TABLE border=1>") | Out-Null
$sb.AppendLine("<TR>") | Out-Null
$sb.AppendLine("<TD>`n`n<TABLE BORDER=1 BORDERCOLOR=GRAY>") | Out-Null


foreach ($team in ($tpHash.Keys | sort-object))
{#team will be TeamProject

	if ($team -eq "BillingAdminProject")
	{
		continue
	}
	
	#write-host $("team: " + $team)
	$tsb = new-object System.Text.StringBuilder
	$c = $tsb.AppendLine("<TR><TH COLSPAN=3 ALIGN=LEFT BGCOLOR=FFF8C6>" + $team + "</TH></TR>")
	$c = $tsb.AppendLine($envHeader.ToString())
	[bool] $needTeamSection = $false
	
	[hashtable] $deploymentType = [hashtable] @{}
	[hashtable] $buildpackageHash = [hashtable]@{}
	
	#[hashtable] $buildHash = @{}
	
	#looping throught each team build type 
	#deployment row for the TeamProject
	foreach ($deploymentHash in $tpHash[$team])
	{
		#Write-Host $("BuildType: " + $buildType)
		[hashtable] $buildHash = @{}
		[bool] $rowNeeded = $false
		[string] $name = ""
		[string] $buildType = $deploymentHash["TeamBuildType"]
		
		foreach ($_env in $environments)
		{
			[xml] $xml = $deploymentHash[$_env]
			
#Xml example
#			<?xml-stylesheet type="text/xsl" href="EnvironmentMapping.xsl"?>
#			<Environments xmlns:xsi="http://tempuri.org/XMLSchema.xsd" 
#					LastUpdated="03/09/2009 20:39:34" 
#					xsi:noNamespaceSchemaLocation="SRMEnvironmentMappings.xsd">
#					
#				<Environment Name="Production">
#					<Builds>
#						<Build TeamProject="AgentPortal.Project" 
#							TeamBuildType="AgentPortal.Release" 
#							BuildNumber="AgentPortal-4.29.0.1" 
#							TimeStamp="03/09/2009 20:39:34" 
#							RollBackBuild="AgentPortal-4.28.0.22" 
#							DeployedBy="CORP\DSCHELL" />
#					</Builds>
#				</Environment>
#			</Environments>
			
		 	$buildNode = $xml.CreateElement("Build")
			
			if ($_env -match "Dev" -or $_env -eq "IRB")
			{
				continue
			}
			
			
			if ($xml.Environments)
			{
				$buildNode = get-BuildNode $_env $buildType $xml
				
				$bname, $bnumber = split-BuildNumber $buildNode
				
				
				if ($name -eq "" -and $bname -ne "")
				{
					$name = $bname -replace "\.TST1", ""
					
					$buildHash.Add("name", $name.Trim())
				}
				
				$rowNeeded = $true
				$needTeamSection = $true
				
				
			}
			
			
			#need to check to see if there is already a build of this
			#this type and check if the deployment is older
			
			$buildHash.Add($_env, $buildNode)
			
			
		}
		
		if ($team -eq "WmProjects" -and !$buildHash["name"].StartsWith("wM"))
		{ #skippack very old build types 
			continue
		}
		
		if ($rowNeeded)
		{
			if ($deploymentType.Containskey($buildHash["name"]))
			{
				$deploymentType = compare-deploymentTypes $deploymentType $buildHash
			}
			else
			{
				$deploymentType.Add($BuildHash["name"], $buildHash)
			}
		}
			
	}
	
	if ($needTeamSection)
	{
		foreach ($buildRow in ($deploymentType.Keys | Sort-Object))
		{
			$tsb.AppendLine($(create-BuildRow $deploymentType[$buildRow] )) | Out-Null
		}
		
		$sb.AppendLine($tsb.ToString()) | Out-Null
	}
	
}

$c = $sb.AppendLine("</TABLE>")
$c = $sb.AppendLine("</TD>")
$c = $sb.AppendLine("</TR>")
$c = $sb.AppendLine("</TABLE>")
$c = $sb.AppendLine("</BODY>")
$c = $sb.AppendLine("</HTML>")

Set-Content -path $reportOutputPath -val $sb.ToString()

$conn.Close()
Write-Host "Complete"
