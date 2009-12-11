#Get-DataConnectionLib
#This script will get Data Contection Libraries
#
#Return: Microsoft.SharePoint.SPDocumentLibrary object 

param([string] $siteUrl = $(throw 'The Full Site URL is required'),
	  [string] $dclName = $(throw 'The Data Connection Library name is required'),
	  [bool] $create = $($false))
function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

###MIAN##

[System.Reflection.Assembly]::LoadWithPartialName(”Microsoft.SharePoint”) > $null

$site = new-object Microsoft.SharePoint.SPSite($siteUrl)
$web = $site.openweb()
Set-Variable -Name dcl

if ($web.lists | Select Title | where { $_.Title -eq $dclName})
{
	$dcl =  $($web.lists | where { $_.Title -eq $dclName})
}
elseif ($create)
{
	$template = $web.ListTemplates["Data Connection Library"]
	$guid = ($web.Lists.Add($dclName, $dclDescription, $template))
	$dcl = $web.lists[$guid]
	$dcl.EnableModeration = $false 
	$dcl.Update()
}
else
{
	$dcl =  $null
}

$web.dispose()
$site.dispose()

return $dcl 