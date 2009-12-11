param(  [string] $tfsUrl = "Http://as73tfstst01:8080", 
        [string] $tp = "TestII.Projects",
        [string] $wiTypeName = "Deployment Backlog Item")

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

$script = get-script
$script_folder = split-path $script
Push-Location $script_folder
$tfs = .\Get-tfs.ps1 $tfsUrl
$wiType = $tfs.wit.projects | Where-object {$_.Name-eq $tp} | foreach {$_.WorkItemTypes} | where {$_.Name -eq $wiTypeName}

 $wi = new-object Microsoft.TeamFoundation.WorkItemTracking.Client.WorkItem($wiType)
 return $wi 





