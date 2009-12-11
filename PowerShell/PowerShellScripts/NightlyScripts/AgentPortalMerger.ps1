function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

$script = get-script
$script_folder = split-path $script
Push-Location $script_folder

$wsPath = "C:\temp\NightlyScripts\Workspaces\AgentPortalNightlyMerge"
$sourceBranch = "$/AgentPortal.Project/Branches/DEVELOPMENT"
$targetBranch = "$/AgentPortal.Project/Branches/DEV-LONGTERM"

if (!$(test-path $wsPath))
{
	mkdir $wsPath
}

$results = ..\TFVC-Merge.ps1 $wsPath $sourceBranch $targetBranch

$rec = "webdevelopment@harleysvilleGroup.com;vstfhelp@harleysvillegroup.com"
#$rec = "bhopenw@harleysvilleGroup.com;vstfhelp@harleysvillegroup.com"
$sub = $("Successful merge: " + $sourceBranch + " merged to " + $targetBranch)
$body = $("Successful merge: " + $sourceBranch + " merged to " + $targetBranch)
$footNote = "Please contact the <a href=`"mailto:SRM@harleysvillegroup.com`" > SRM group </a> is you have any questions about this message"

if (!$results.wasMergeSuccessful)
{
	$sub = $("Merge failure: " + $sourceBranch + " merged to " + $targetBranch)
	$body = $("Merge failure message: " + $results.errorMessage + "<br>A manual merge maybe required<br>")	
}

Push-Location $script_folder
..\Send-Email.ps1 $rec $sub $($body + "<br>" + $footNote) 