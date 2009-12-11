# By Michael Blumenthal
############################################ 
# Clear-Alerts-From-SPWeb -URL <URL of parent web>
# Delete all alets in a SharePoint site (an SPWeb, not a site collection, not a Web Application)
# Assumes you have already loaded the definition for Get-SPWeb, 
# which you can find at 
# http://sharepoint.microsoft.com/blogs/zach/Lists/Posts/Post.aspx?List=90bbfd11-c9a5-45cf-a77e-19559aae81ae&ID=7
############################################ 
function global:Clear-Alerts-From-SPWeb($URL)
{ 
	$web = Get-SPWeb -url $URL;
	$alerts = $web.Alerts;
	
	$itemCount = $Alerts.Count;
	$webName = $web.Title
	Write-Host "$itemCount alerts found on $webName site."
	
	for ($i=$alerts.Count -1; $i -ge 0; $i -= 1) 
	{
			$alerts.Delete($i);
			$percentComplete = (($itemCount-$i)/$itemCount)* 100
			Write-Progress -Activity "Deleteing item $i in $ListName" -PercentComplete $percentComplete -Status "Please wait."
	}
	Write-Host "$itemCount alerts deleted on $webName site."

	$web.Dispose();
	
} 
