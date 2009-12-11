##Invoke-SqlDeployemtScripts 
#this script will be called as part of the DB Red Gate Sync scripts 
#it will reference the the Scripts folders in the DB TFVC control 
#area 

param([string] $connStr = $(throw 'The connection string is required'),
	  [System.IO.FileInfo] $dbXml = $(throw 'The path to the DB Deploy XML is required'),
	  [string] $dtype = $(throw 'The deployment type is required, either Post or Pre'),
      $deployer = $(throw 'The SRM TFS Deployer object is required'),
	  [bool] $runBackup = $($true))

trap
{
	$deployer.logger.log($("In Trap error: " + $_.ToString()), "error")
	
	if ($tranStarted)
	{
		if ($script.ContinueOnError -eq "True")
		{
			[string] $errmsg = "TSQL error transaction skipped ContinueOnError set to True.  Error msg: " + $_.ToString()
			$deployer.message.AppendLine($errmsg) 
			$deployer.logger.log($errmsg, "error")
			
			##ToDO: figure out way to continue back into Foreach not after foreach 
			#until then we'll have to break when TSQL scripts syntax errors 
			continue
		}
		else
		{
			$server.ConnectionContext.RollbackTransaction()
			[string] $errmsg = "TSQL error transaction rolled back " + $_.ToString()
			$deployer.message.AppendLine($errmsg) 
			$deployer.logger.log($errmsg, "error")
		}
		
	}
	
	break
	
}

function update-DynamicScript ([string] $_tsql, [string] $dbname, [string] $servername)
{
	$_tsql = $_tsql -replace "\$\[DBName\]", $dbname
	$_tsql = $_tsql -replace "\$\[ServerName\]", $servername
	
	[regex] $drx = [regex] "\$\[D\:(\w+?)\]"
	foreach ($m in $drx.matches($_tsql))
	{
		$dateCode = $m.groups[1].value
		$_tsql = $_tsql -replace $($drx.tostring() -replace "\(\\w\+\?\)", $dateCode), $(get-date).ToString($dateCode)
	}
	
	return $_tsql
}

###MAIN###

#load assemblies
[System.Reflection.Assembly]::Load("Microsoft.SqlServer.Smo,Culture=Neutral,Version=9.0.242.0,PublicKeyToken=89845dcd8080cc91") | out-null
[System.Reflection.Assembly]::Load("Microsoft.SqlServer.ConnectionInfo,Culture=Neutral,Version=9.0.242.0,PublicKeyToken=89845dcd8080cc91") | out-null
[System.Reflection.Assembly]::Load("System.Data,Culture=Neutral,Version=2.0.0.0,PublicKeyToken=b77a5c561934e089") | out-null
[System.Reflection.Assembly]::Load("Microsoft.SqlServer.SqlEnum,Culture=Neutral,Version=9.0.242.0,PublicKeyToken=89845dcd8080cc91") | out-null

$deployer.logger.log($("In deployment sql scripts: " + $dtype, "debug"))

$hpp = get-location 

[bool] $tranStarted = $false

$conn = New-Object System.Data.SqlClient.SqlConnection($connStr)
$deployer.logger.log("SQL connection successful", "debug")

$sconn = new-object Microsoft.SqlServer.Management.Common.ServerConnection($conn)
$deployer.logger.log("SQL Server connection successful", "debug")

$server = new-object Microsoft.SqlServer.Management.Smo.Server($sconn)
$deployer.logger.log("SMO successful", "debug")


if ($runBackup -and 
	$deployer.RegionName.ShortName -ne "ASY" -and
	$dtype -eq "Pre")
{
	
	[string] $url = $deployer.config.deployment.Urls.SQLBackupMonitor + "?Server=" + $conn.DataSource + '&' + "Database=" + $conn.Database
	
	$deployer.Mailer.Recipient = $deployer.EmailRecipient
	
	$deployer.Mailer.Subject = $conn.Database + " Backup started on server " + $conn.DataSource
	
	$deployer.Mailer.body  = "To see backup progress go to this link<br>"  
	$deployer.Mailer.body += "<a href=`"$url`" >Backup progess for $($conn.database)</a>"
	$deployer.Mailer.Send()
	
	pushd $hpp.Path
	[string] $tsqlBkp = .\TFSDeployerScripts\New-SQLBackup $('\\us73media1\SRM\<SERVER>_<DATABASE>_<TYPE>_<DATETIME yyyymmdd_ hhnnss>.sqb') $($conn.Database) $("Backup before sync job for build: " + $deployer.builddata.Buildnumber)
	popd
	
	[string] $bkpmsg = "Backing up database $($conn.Database) on $($conn.DataSource) this could take a while`n$tsqlBkp" 
	
	$deployer.message.AppendLine($bkpmsg) 
	$deployer.logger.log($bkpmsg, "info")

	$returnDataset = $server.ConnectionContext.ExecuteWithResults($tsqlBkp)
	
	$exitcode = $returnDataset.tables[1].select("Name like 'exitcode'")
	[string] $backupReport = $returnDataset.Tables[0] | Out-String 
	
	if (-not $exitcode.value -eq 0)
	{
		$deployer.logger.log($backupReport, "ERROR")
		throw "Error: backup failed; $backupReport"
	}
	
	$backupReport = $returnDataset.Tables[0] | Out-String 
	
	$deployer.message.AppendLine($backupReport) 
	$deployer.logger.log($backupReport, "info")
	
	$deployer.Mailer.Subject = $conn.Database + " Backup complete"
	
	$deployer.Mailer.body  = $backupReport
	
	$deployer.Mailer.Send()
}
elseif ($deployer.RegionName.ShortName -eq "ASY" -and
	    $dtype -eq "Pre")
{
	$deployer.logger.log("No DB backups run in ASY", "info")
}

if ($dbXml -ne $null)
{
	pushd $(split-path $($dbXml.FullName) -Parent)
	
	[xml] $xml = [xml] (gc $dbXml.FullName)
	
	switch ($dtype)
	{
		"Pre" 
		{
			if (!$($($xml.Scripts.DeployType) -eq "Pre-Deploy"))
			{
				throw "ERROR: The scripts Xml is not Pre Deployment typed scripts" 
			}
		}
		"Post"
		{
			if (!$($($xml.Scripts.DeployType) -eq "Post-Deploy"))
			{
				throw "ERROR: The scripts Xml is not Post Deployment typed scripts" 
			}
		}
		
		default
		{
			throw "ERROR: $dtype is not a valid Deployment type (Post or Pre)"
		}
	}
	
	
	$deployer.logger.log("Tansaction starting", "debug")
	$tranStarted = $true
	$server.ConnectionContext.BeginTransaction()
	[int] $scriptsRun = 0
	
	foreach ($script in $xml.Scripts.Script)
	{
		$deployer.logger.log($("found sql script: " + $script.Path), "debug") 
		
		[int] $numRows = 0
		
		if ($script.run -eq "True")
		{
			$deployer.logger.log($("Run sql script: " + $script.Path + " set to true"), "debug")
			$scriptsRun++
			
			[System.IO.FileInfo] $sfile = Get-Item $script.path
			
			if ($sfile.Exists)
			{
				$deployer.logger.log($("Running sql script: " + $script.Path ), "debug")
				[string] $tsql = $($sfile.OpenText().ReadToEnd())
				
				if($script.type -eq "Dynamic")
				{
					$tsql = update-DynamicScript $tsql $conn.Database $conn.DataSource
				}
				
				$numRows = $server.ConnectionContext.ExecuteNonQuery($tsql)
				$deployer.logger.log($("Run sql script: " + $script.Path + " complete"), "debug")
				
				
				if ($numRows -ge 0)
				{
					[string] $msg = "$dtype deployment script ($($script.path) ran and updated $numRows rows"
					
					$deployer.message.AppendLine($msg) 
					$deployer.logger.log($msg, "info")
				}
				elseif ($numRows -eq -1)
				{#script ran but no rows were effected
					$deployer.message.AppendLine("$dtype deployment script ($($script.path) successfully ran") 
				}
				elseif ($script.ContinueOnError -eq "False")
				{
					$server.ConnectionContext.RollbackTransaction()
					$tranStarted = $false
					$conn.Close()
					[string] $err = "Error: $($sfile.FullName) script did not successfully run; error code: $numRows.ToString()"
					$deployer.logger.log($err, "error")
					throw $err
				}
				else
				{
					$server.ConnectionContext.RollbackTransaction()
					$tranStarted = $false
					$conn.Close()	
					[string] $errmsg = "$dtype deployment script ($($script.path) unsuccessfully ran but continue on Error was true therefore scripts continued"
					$deployer.message.AppendLine($errmsg) 
					$deployer.logger.log($errmsg, "warning")
				}
				
			}
			elseif ($scripts.ContinueOnError -eq "False")
			{
				$server.ConnectionContext.RollbackTransaction()
				$tranStarted = $false
				$conn.close()
				[string] $err = "Error: $($sfile.FullName) not found; Transaction was rollbacked"
				
				$deployer.logger.log($err, "error")
				throw $err
			}
			else
			{
				[string] $wrn = "Warning: Script skipped; $($script.path) was not found and was skipped"
				$deployer.logger.log($wrn, "warning")
				$deployer.message.AppendLine($wrn)
			}
		}
		else
		{
			[string] $infomsg = "$dtype deployment script ($($script.path) was skipped due to `"run`" attribute is to set False" 
			$deployer.message.AppendLine($infomsg)
			$deployer.logger.log($infomsg, "debug")
			
		}
	}
	
	$server.ConnectionContext.CommitTransaction()
	$tranStarted = $false
	[string] $imsg = "$dtype Deployment scripts commited"
	
	if ($scriptsRun -le 1)
	{
		$imsg += " although no scripts were run"
	}
	
	$deployer.message.AppendLine($imsg)
	$deployer.logger.log($imsg, "info")
	
	popd

}

$conn.Close()