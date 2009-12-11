# By Michael Blumenthal
############################################ 
# Delete-SPField -FieldName <field name> -ListName <name of list> -URL <url of parent web> 
# Delete a particular Field from a SharePoint list
# Assumes you have already loaded the definition for Get-SPWeb, 
# which you can find at 
# http://sharepoint.microsoft.com/blogs/zach/Lists/Posts/Post.aspx?List=90bbfd11-c9a5-45cf-a77e-19559aae81ae&ID=7
############################################ 
function global:Delete-SPField($FieldDisplayName, $ListName, $URL)
{ 
	$web = Get-SPWeb -url $URL;
	$list = $web.Lists[$ListName];
	$fieldCollection = $list.Fields;
	$fieldCollection.Delete($fieldCollection[$FieldDisplayName].InternalName);
	$web.Dispose();
	Write-Host "Removed $FieldDisplayName from $ListName."
}

