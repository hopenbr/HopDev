# By Michael Blumenthal
############################################ 
# Get-Workflow-Association-By-Name -URL <URL of parent web> -ListName <Display name of List> -WFAName <Display name of workflow association>
# Get the SPWorkflowAssociation object from a list of associations in a List.
# Assumes you have already loaded the definition for Get-SPWeb, 
# which you can find at 
# http://sharepoint.microsoft.com/blogs/zach/Lists/Posts/Post.aspx?List=90bbfd11-c9a5-45cf-a77e-19559aae81ae&ID=7
############################################ 
function global:Get-Workflow-Association-By-Name($URL, $ListName, $WFAName)
{ 
 $web = Get-SPWeb -url $URL;
 $list = $web.Lists[$ListName];
 $listName = $list.Title;
 $wfaCollection = $list.WorkflowAssociations;
 $AssocCount = $wfaCollection.Count.ToString();
 Write-Host "There were $AssocCount workflow associations in $listName.";
 for ($i=0; $i -lt $wfaCollection.Count; $i++) 
 {
	if ($wfaCollection[$i].Name -eq $WFAName)
	{
		$association = $wfaCollection[$i];
	}
  }
  return $association;
 $web.Dispose();
}