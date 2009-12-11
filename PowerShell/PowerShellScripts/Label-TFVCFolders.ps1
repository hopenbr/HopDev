#####
#Set-TFVCLabel.ps1
#This filter script take a collection of TFVC server path strings pointing to folders in TFVC 
#and labels that folder recursion is optional 
#
#Parameter:
#0 (labelName) name of label, 
#	if label already exist label child option is set to replace otherwise new label is created
#1 (User Name) User ID of label owner
#	If label exist needs to owner of label 
#2 (recursive) recursion type None,OneLevel,Full default None, None is used if bad string is passed
#3 (Tfs Server Url) Default http://as73tfs01:8080
#
#Returns hashtable of results, key server path vaule if added to label collect 
#  Key: LabelResults ==> LabelResult instance
####

param([string] $labelName = $(throw 'The label name is required'),
	  [string] $userName = $(throw 'The label owner user name is required'),
	  [string] $recursive = $("none"),
      [string] $serverUrl = ("http://as73tfs01:8080")) 

  
begin
{

	[void] [Reflection.Assembly]::LoadWithPartialName("Microsoft.TeamFoundation.Client")
	[void] [Reflection.Assembly]::LoadWithPartialName("Microsoft.TeamFoundation.VersionControl.Client")
	
	$tfs1 = New-Object Microsoft.TeamFoundation.Client.TeamFoundationServer($serverUrl)
	$vcs = $tfs1.GetService([Microsoft.TeamFoundation.VersionControl.Client.VersionControlServer])

	$label = New-Object Microsoft.TeamFoundation.VersionControl.Client.VersionControlLabel($vcs, $labelName, $userName, $null, $comment)
	
	[hashtable] $results = @{"LabelResults" = $null}

	[Array] $labelItemSpecs = @()
	
	switch ($recursive)
	{
		"Full" {}
		"None" {}
		"OneLevel" {}
		default {$recursive = "None"}	
	}
	
	$recurse = [Microsoft.TeamFoundation.VersionControl.Client.RecursionType]::$recursive
}

process
{
	if ($vcs.ServerItemExists($_, [Microsoft.TeamFoundation.VersionControl.Client.ItemType]::Folder))
	{		
		$itemSpec = New-Object Microsoft.TeamFoundation.VersionControl.Client.Itemspec ($_, $recurse)
		
		$labelItemSpecs += New-Object Microsoft.TeamFoundation.VersionControl.Client.labelItemspec ($itemSpec, [Microsoft.TeamFoundation.VersionControl.Client.ChangesetVersionSpec]::Latest, $false)
		
		$results.Add($_, "Added")
	}
	else
	{
		$results.Add($_, "Invalid server path")
	}
}

end
{

	if ($labelItemSpecs.Count -gt 0)
	{
		$results["LabelResults"] = $vcs.CreateLabel($label, $labelItemSpecs, [Microsoft.TeamFoundation.VersionControl.Client.LabelChildOption]::Replace)
	}
	
	return $results
}