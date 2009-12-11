# By Michael Blumenthal
############################################ 
# Delete-ContentType -ContentTypeName <name> -ListName <name of list> -URL <url of parent web> 
# Delete a content type from a SharePoint list
# Assumes you have already loaded the definition for Get-SPWeb, 
# which you can find at 
# http://sharepoint.microsoft.com/blogs/zach/Lists/Posts/Post.aspx?List=90bbfd11-c9a5-45cf-a77e-19559aae81ae&ID=7
############################################ 
function global:Delete-ContentType($ContentTypeName, $ListName, $URL)
{ 
	$web = Get-SPWeb -url $URL;
	$list = $web.Lists[$ListName];
	$contentTypeCollection = $list.ContentTypes;
	$contentTypeCollection.Delete($contentTypeCollection[$ContentTypeName].Id);
	$web.Dispose();
	Write-Host "Removed $ContentTypeName from $ListName."
}

