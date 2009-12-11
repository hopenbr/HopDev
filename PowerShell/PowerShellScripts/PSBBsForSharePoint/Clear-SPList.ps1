# By Michael Blumenthal
############################################ 
# Clear-SPList -ListName <name of list> -URL <URL of parent web>
# Delete all items in a SharePoint list
# Assumes you have already loaded the definition for Get-SPWeb, 
# which you can find at 
# http://sharepoint.microsoft.com/blogs/zach/Lists/Posts/Post.aspx?List=90bbfd11-c9a5-45cf-a77e-19559aae81ae&ID=7
############################################ 
function global:Clear-SPList($ListName, $URL)
{ 
	$web = Get-SPWeb -url $URL;
	$list = $web.Lists[$ListName];
	$items = $list.Items;
	
	$itemCount = $items.Count;
	Write-Host "$itemCount items found in $ListName."
	
	for ($i=$items.Count -1; $i -ge 0; $i -= 1) 
	{
			$items.Delete($i);
			$percentComplete = (($itemCount-$i)/$itemCount)* 100
			Write-Progress -Activity "Deleteing item $i in $ListName" -PercentComplete $percentComplete -Status "Please wait."
	}

	$web.Dispose();
	
} 
