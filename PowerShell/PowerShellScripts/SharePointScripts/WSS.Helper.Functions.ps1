##Helper.Functions.ps1
#this script will set a number of global functions and alias. 


[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint") > $null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Deployment") > $null
 
Write-Host -ForegroundColor Green "Enabling HPP Sharepoint Alaises and Functions"

New-Variable -Name "HelperFunctions" -Value "1" -Scope global

function global:push-StsadmDir
{
	push-location "C:\Program Files\Common Files\Microsoft Shared\web server extensions\12\BIN"
}


set-alias psp push-StsadmDir -option AllScope -Scope Global

set-alias -name sa -value "C:\Program Files\Common Files\Microsoft Shared\web server extensions\12\BIN\STSADM.exe" -option AllScope -Scope Global

function  global:sah ([string] $match)
{
	sa -help | ?{$_ -match $match}
}


function global:wh ([string] $op)
{
	write-host -ForegroundColor Yellow $op
}

function global:ExportSPList
{	
	param([string] $ListUrl = $(throw 'Full Url to list to export is required'),
          [string] $path2DatFile = $("C:\Temp\BackupRestoreTemp\"))

	$versions = [Microsoft.SharePoint.Deployment.SPIncludeVersions]::All
	
	$exportObject = New-Object Microsoft.SharePoint.Deployment.SPExportObject
	$exportObject.Type = [Microsoft.SharePoint.Deployment.SPDeploymentObjectType]::List 
	$exportObject.IncludeDescendants = [Microsoft.SharePoint.Deployment.SPIncludeDescendants]::All
	
	$settings = New-Object Microsoft.SharePoint.Deployment.SPExportSettings
	
		
	$settings.ExportMethod = [Microsoft.SharePoint.Deployment.SPExportMethodType]::ExportAll
	$settings.IncludeVersions = $versions
	$settings.IncludeSecurity = [Microsoft.SharePoint.Deployment.SPIncludeSecurity]::All
	$settings.OverwriteExistingDataFile = 1
	
	$site = new-object Microsoft.SharePoint.SPSite($ListURL)
	Write-Host "ListURL", $ListURL
	
	$web = $site.OpenWeb()
	$list = $web.GetList($ListURL)
	
	[string] $fileName = "List-"+ $list.ID.ToString()
	
	$settings.SiteUrl = $web.Url
	$exportObject.Id = $list.ID
	$settings.FileLocation = $path2DatFile
	$settings.BaseFileName = $fileName  +".DAT"
	$settings.FileCompression = 1
	
	Write-Host "FileLocation", $settings.FileLocation
	
	$settings.ExportObjects.Add($exportObject)
	
	$export = New-Object Microsoft.SharePoint.Deployment.SPExport($settings)
	$export.Run()
	
	$ListUrl | out-file -filePath $(Join-Path $path2DatFile $($fileName + ".url")) -encoding ASCII
	
	$web.Dispose()
	$site.Dispose()
}


function global:ImportSPList
{
	param([string]$DestWebURL = $(throw 'The full url of new list is required'), 
		  [string]$FileName = $(throw 'The full UNC path to the DAT file is required'), 
		  [string]$LogFilePath = $("C:\SPListImport.log"))

	$settings = New-Object Microsoft.SharePoint.Deployment.SPImportSettings
	
	$settings.IncludeSecurity = [Microsoft.SharePoint.Deployment.SPIncludeSecurity]::All
	$settings.UpdateVersions = [Microsoft.SharePoint.Deployment.SPUpdateVersions]::Overwrite 
	$settings.UserInfoDateTime = [Microsoft.SharePoint.Deployment.SPImportUserInfoDateTimeOption]::ImportAll
	
	$site = new-object Microsoft.SharePoint.SPSite($DestWebURL)
	
	Write-Host "DestWebURL", $DestWebURL
	
	$web = $site.OpenWeb()
	
	Write-Host "SPWeb", $web.Url
	
	$settings.SiteUrl = $web.Url
	$settings.WebUrl = $web.Url
	$settings.FileLocation = $(Split-Path $FileName -Parent)
	$settings.BaseFileName = $(Split-Path $FileName -Leaf)
	$settings.LogFilePath = $LogFilePath
	$settings.FileCompression = 1
	
	Write-Host "FileLocation", $settings.FileLocation
	
	$import = New-Object Microsoft.SharePoint.Deployment.SPImport($settings)
	$import.Run()
	
	$web.Dispose()
	$site.Dispose()
}

function global:ImportSiteUDCXLibraries
{
	param([string] $url = $(throw 'The full url to the site is required'),
      	  [string] $datFolder = $(throw 'The full unc path to the dat files folder is required'),
		  [string] $logFolder = $("C:\SPImport\" + $(Get-Date).ToString("yyyyMMddhhmmmsss")))
		  
	if (-not $(Test-Path $datFolder))
	{
		throw "ERROR: Dat file folder was not folder at: $datFolder"
	}
	else
	{
		wh "Importing UDCX libraries from list backups in $datFolder"
		
		ls $(Join-Path $datFolder "*.url") |
			%{
				[string] $udcxUrl = gc $_

				[string] $udcxDat = $_ -replace "\.url", ".dat"

				[string] $logName = $_ -replace "\.url", ".log"

				[string] $logFile = $(Join-path $logFolder $logName)
				
				ImportSPList $udcxUrl $udcxDat $logFile
				
				
			}
		
		wh "UDCX Import Complete"
			
	}
	
}


function global:ExportSiteUDCXLibraries
{
	param([string] $url = $(throw 'The full url to the site is required'),
      	  [string] $datFolder = $("C:\SPExports\" + $(Get-Date).ToString('yyyyMMdd')))

	$site = new-object Microsoft.SharePoint.SPSite($URL)
	
	$web = $site.OpenWeb()
	
	$web.lists | 
		?{$_.title -match "UDCX" } | 
			%{ 
				[string] $udcxUrl = $($web.Url + "/" +  $_.rootfolder)
	
				wh "Exporting $udcxUrl" 
				
				ExportSPList $udcxUrl $datFolder 
				
				wh "export Complete"
	
			}
	
	
	$web.Dispose()
	
	$site.Dispose()
}

function global:ActivateLGBPInfoPathForms
{
	param([string] $siteUrl = $(throw 'Full URL to site is required'))
	
	wh "Activating LGBP InfoPath forms to $siteUrl"
	wh "This may take a while..."
	
	sa -o enumformtemplates | 
		?{$_ -match "2008-"} | 
			%{$_.Split("`t")[1]} | 
				%{
					sa -o activateformtemplate -url $siteUrl -formid $_ 
				}
}




