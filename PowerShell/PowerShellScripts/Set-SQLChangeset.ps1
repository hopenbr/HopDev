#Set-SQLChangeset
#this script set up SQL Changeset for use with a SCP and local workspace
param([string] $serverPath = $(throw 'The TFVC server path to DB schema is required'),
      [string] $localPath = $(throw 'The local path to workspace is required'),
	  [string] $tfsUrl = $('http://as73tfs01:8080'))


###MAIN###
$ErrorActionPreference = "Stop"

write-debug "Starting"

#using 
[void] [Reflection.Assembly]::LoadWithPartialName("Microsoft.TeamFoundation.Client")
[void] [Reflection.Assembly]::LoadWithPartialName("Microsoft.TeamFoundation.VersionControl.Client")

#set variables 
$tfs = New-Object Microsoft.TeamFoundation.Client.TeamFoundationServer($tfsUrl)
$vcs = $tfs.GetService([Microsoft.TeamFoundation.VersionControl.Client.VersionControlServer])
$wsCurrent = [Microsoft.TeamFoundation.VersionControl.Client.Workstation]::Current

#may push to this to config file 
[string] $wsName = "SQLChangeset_" + $(Split-Path $localPath -leaf)
[string] $path2ConfigXml = "C:\Documents and Settings\$($Env:USERNAME)\Local Settings\Application Data\Red Gate\SQL Changeset\Configuration.xml"
[string] $path2sqlCs = "C:\Program Files\Red Gate\SQL Compare 8\SQL Changeset\RedGate.SqlChangeset.exe"
[string] $user = $Env:USERDOMAIN + "\" + $Env:USERNAME

if (-not (Test-Path $path2ConfigXml))
{
	#SQL Changeset has not been started for first time
	
	Write-warning "Starting SQL Changeset for first time" 
	Write-Warning "Please close once started"
	
	& $path2sqlCs
	
}

#we need to be sure that SQL CS is not running 
#if it is we need to find out what to do 

while ($(Get-Process | ?{$_.Name -eq 'RedGate.SqlChangeset'})) 
{
	Write-Host "SQL Changeset cannot be running while this process is completed"
	
	Write-Host "To exit right-click on the SQL ChangeSet icon in the notification"
	
	Write-Host "area  in the right hand side of the status bar where the clock usually is"
		
	switch -regex (Read-Host -Prompt "[R] Retry, [K] Kill the process, [A] Abort")
	{
		"R|r"{}
		"A|a"
		{
			write-host -ForegroundColor Red "Abort: Cannot continue with Red Gate SQL Changeset running"
			return
		}
		"K|k"
		{
			Write-Warning "Killing the process may have unkown effects on SQLChangeset"
			switch -regex (Read-Host -Prompt "Are you sure you want to kill the SQL Changeset process [Y/N]")
			{
				"Y|y" 
				{
					$sqlcs = $(Get-Process | ?{$_.Name -eq 'RedGate.SqlChangeset'})
			
					$sqlcs.Kill()
			
					sleep -Seconds 5
				}
				
				"N|n"
				{}
			}
			
		}
	}
}



if (-not (Test-Path $localPath))
{
	New-Item -Path $(Split-Path $localPath -Parent) -Name $(Split-Path $localPath -leaf) -ItemType Directory | Out-Null
}
else
{

	if ($wsCurrent.IsMapped($localPath))
	{
		Write-Host -ForegroundColor Red "Error: Local path already mapped; $localPath is already mapped on this workstation" 
		
		return
		
	}
	
	
}

#check to ensure a workspace with same name not already created 
if($wsCurrent.GetAllLocalWorkspaceInfo() | ?{$_.Name -match $wsName})
{
	Write-Host -ForegroundColor Red "Error: workspace name - $wsName - already in use"
	Write-Host "Workspace name is taken for the local path directory name"
	return
}

##assume directy name is a good name ie DB name
$ws = $vcs.createworkspace($wsName)

$ws.map($serverPath, $localPath)

Write-Debug "Workspace created"

[System.IO.FileInfo] $configXml = Get-Item $path2ConfigXml

Copy-Item -Path $configXml.FullName -Destination $($configXml.FullName + ".bak") -Force

[string] $configXmlContents = gc $configXml
#check to make sure the server path has not already been used 
Write-Debug "configuration xml backed up"

#search 
if ($configXmlContents -match "\$serverPath")
{
	Write-Host -ForegroundColor Red "Error: $serverPath already in use in SQL Changeset"
	Write-Host "Workspace will be deleted"
	$ws.delete()
	return
}

[xml] $xml = [xml] (gc $configXml)

$projects = $xml.ConfigurationFile.SelectSingleNode("Projects")

#need to crate xml elements 
[System.Xml.XmlElement] $pair = $xml.CreateElement("PairOfScProviderOpenProjectInfo")
[System.Xml.XmlElement] $scp = $xml.CreateElement("ScProvider")
[System.Xml.XmlElement] $scpC = $xml.CreateElement("ScProvider")
[System.Xml.XmlElement] $opi = $xml.CreateElement("OpenProjectInfo")
[System.Xml.XmlElement] $opiC = $xml.CreateElement("OpenProjectInfo")

$scpC.SetAttribute("Name", "Team Foundation Server MSSCCI Provider")
$scpC.SetAttribute("Registry", "SOFTWARE\Microsoft\Team Foundation Server MSSCCI Provider")
$scpC.SetAttribute("Dll", "C:\Program Files\Microsoft Team Foundation Server MSSCCI Provider\TfsMsscciProvider.dll")

$scp.AppendChild($scpC)

Write-Debug "Updating configuration xml"

#This is the path SQL CS uses 
#I think the info it needs to get the workspace object 
[string] $wsPath = "$tfsUrl/|$wsName|$user"

$opiC.SetAttribute("LocalPath", $localPath)
$opiC.SetAttribute("Name", $serverPath)
$opiC.SetAttribute("Path", $wsPath)
$opiC.SetAttribute("User", $user)

$opi.AppendChild($opiC)

$pair.AppendChild($scp)
$pair.AppendChild($opi)

$projects.AppendChild($pair)

$xml.Save($configXml.FullName)

Write-Host "SQL Changeset has been successfully updated"
Write-Host "Starting SQL Changeset"
& $path2sqlCs

