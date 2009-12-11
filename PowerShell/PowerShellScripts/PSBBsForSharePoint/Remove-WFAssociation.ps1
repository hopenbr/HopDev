# By Michael Blumenthal
############################################ 
# Remove-Workflow-Association-By-Name -URL <URL of parent web> -ListName <Display name of List> -WFAName <Display name of workflow association>
# Removes the SPWorkflowAssociation object from a collection of associations in a List.
# Assumes you have already loaded the definition for Get-SPWeb, 
# which you can find at 
# http://sharepoint.microsoft.com/blogs/zach/Lists/Posts/Post.aspx?List=90bbfd11-c9a5-45cf-a77e-19559aae81ae&ID=7
# also depends on Get-Workflow-Association-By-Name
############################################ 
function global:Remove-Workflow-Association-By-Name($URL, $ListName, $WFAName)
{ 
	$wfa =  Get-Workflow-Association-By-Name -url $URL -listName $ListName -WFAName $WFAName
	wfa.ParentList.RemoveWorkflowAssociation($wfa);
}