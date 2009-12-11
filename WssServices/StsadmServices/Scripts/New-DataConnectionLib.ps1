#New-DataConnectionLib
#This script will create Data Contection Libraries
#
#Return: Microsoft.SharePoint.SPDocumentLibrary object 

param([string] $siteUrl = $(throw 'The Full Site URL is required'),
	  [string] $dclName = $(throw 'The Data Connection Library name is required'),
	  [string] $dclDescription = $(''))
	  
[System.Reflection.Assembly]::LoadWithPartialName(”Microsoft.SharePoint”) > $null

if (!$($web))
{
	$site = new-object Microsoft.SharePoint.SPSite($siteUrl)
	$web = $site.openweb()
}

$template = $web.ListTemplates["Data Connection Library"]

Set-Variable -Name dcl

if ($web.lists | Select Title | where { $_.Title -eq $dclName})
{
	Write-Error "Data Connection Library `"$dclName`" already exists in $siteUrl"
	$dcl = $null
}
else
{
	$guid = ($web.Lists.Add($dclName, $dclDescription, $template))
	$dcl = $web.lists[$guid]
	$dcl.EnableModeration = $false 
	$dcl.Update()
}

$web.dispose()
$site.dispose()

return $dcl 
