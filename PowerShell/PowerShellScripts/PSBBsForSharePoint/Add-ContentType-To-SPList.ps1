# By Michael Blumenthal
############################################ 
# Add-ContentType-To-SPList -URL <URL of parent web> -ListName <Display name of List> -ContentTypeName <Display name of Content Type>
# Adds the specified content type to the specified list in the specified site.
# Assumes you have already loaded the definition for Get-SPWeb, 
# which you can find at 
# http://sharepoint.microsoft.com/blogs/zach/Lists/Posts/Post.aspx?List=90bbfd11-c9a5-45cf-a77e-19559aae81ae&ID=7
############################################ 
function global:Add-ContentType-To-SPList($URL, $ListName, $ContentTypeName)
{ 
 $web = Get-SPWeb -url $URL;
 $list = $web.Lists[$ListName];
 $ct = $web.AvailableContentTypes[$ContentTypeName];
 $result = $list.ContentTypes.Add($ct);
 Dispose-SPWeb $web;
 Write-Host "$ContentTypeName added to $ListName."
}
 
