# By Michael Blumenthal
############################################ 
# Create-Workflow-Association -URL <URL of parent web> -ListName <Display name of List> 
#	-AssociationName <Display name of workflow association> 
#	-TemplateName <Display name of workflow association>
#	-StartOnCreate <0|1>
# Associates a Workflow with a List.
# Assumes you have already loaded the definition for Get-SPWeb, 
# which you can find at 
# http://sharepoint.microsoft.com/blogs/zach/Lists/Posts/Post.aspx?List=90bbfd11-c9a5-45cf-a77e-19559aae81ae&ID=7
############################################ 
function global:Get-Workflow-Association-By-Name($URL, $ListName, $WFAName, $TemplateName, $TaskListName, $HistoryListName, $StartOnCreate)
{ 
 $web = Get-SPWeb -url $URL;
 $site = $web.Site;
 $list = $web.Lists[$ListName];
 $tasks = $web.Lists[$TaskListName];
 $history = $web.Lists[$HistoryListName];
 $listName = $list.Title;
 $templates = $site.WorkflowManager.GetWorkflowTemplatesByCategory($web, null);
 $wftemplate = $templates.GetTemplateByName($TemplateName, CultureInfo.CurrentCulture);
 $association = SPWorkflowAssociation.CreateListAssociation($wftemplate, $wftemplate.Name, $tasks, $history)
 if ($StartOnCreate -eq 1)
 {
	$association.AutoStartCreate = true;
 }
 $wfaCollection = $list.WorkflowAssociations;
 $AssocCount = $wfaCollection.Count.ToString();
 Write-Host "There were $AssocCount workflow associations in $listName.";
 $list.AddWorkflowAssociation($association);
 $AssocCount = $wfaCollection.Count.ToString();
 Write-Host "Now there are $AssocCount workflow associations in $listName.";
 $web.Dispose();
}

# TODO - TEST ME!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!