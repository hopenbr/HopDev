Param($deployer = $(throw 'SRM TFS Deployer object is requred'))

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 


function get-historycomment
{
    [string] $comment = "";
    if ($deployer.env.contains("RollBack"))
    {
		$comment = $("Build backed out of " + $($deployer.OriginalBuildQuality.split('-'))[1] + " enviroment")
    }
    elseif ($deployer.env.contains("ConfigUpdate"))
    {
		$comment = "Configs for all environments were updated on the Build store to latest versions in TFVC"
    }
    else
    {
		$comment = $deployer.DeploymentNote.Note
	}
	
	$comment += "`nDeployment was kicked off by " + $deployer.BuildData.LastChangedBy
	
	return $comment
} 

function update-RelatedWorkItems ($_tfs, $_wi, $_comment)
{
	foreach ($ln in $_wi.Get_links())
	{ 
		if ($ln.RelatedWorkItemId)
		{
			$_relwi = $tfs.wit.getworkitem($ln.RelatedWorkItemId)
			[bool] $_update = check-WorkItem4Need2Update $_relwi
			if ($_update)
			{
				update-DBI $_relwi $_comment
			}
		}
	}
}

function get-Environment 
{
	$environment = $deployer.env
	
	if ($environment.Contains("-"))
	{
		$environment = $($environment.split('-')[1])
	}
	
	if ($environment.Equals("PrePrd"))
	{
		$environment = "Pre-Prd"
	}
	
	return $environment
	
}

function check-WorkItem4Need2Update ($_work)
{
	$_environment = get-Environment
	
	if ($_work.Type.Name -eq "Deployment Backlog Item" -and
		$_work.Fields["State"].Value.Contains("Approved") -and 
	    $_work.Fields["New Test Environment"].Value -eq $_environment -and 
	    (check-BuildNumbers $_work.Fields["HIC Build Numbers"].Value $_work.Fields["Build Number"].Value) )
	{
		return $True
	}
	else
	{	
		return $False
	}
	
}

function check-BuildNumbers ([string] $_buildNumbers, [string] $_buildNumber)
{
	if ($_buildNumbers.Length -eq 0)
	{
		if ( $_buildNumber -eq $deployer.BuildData.BuildNumber)
		{
			return $true
		}
		else
		{
			return $false	
		}
	}
	else
	{
	    [bool] $buildNumberMatch = $false
	    
		foreach ($build in $_buildNumbers.split(","))
		{
			if ( $build -eq $deployer.BuildData.BuildNumber)
			{
				$buildNumberMatch = $true
			}
		}
		
		return $buildNumberMatch
	}
}

function update-DBI ($_dbi, $_comment)
{
	$deployer.Logger.Log("Updating work item DBI# $_dbi.Id.ToString()", "info")
	$_dbi.open()
	$_relComment = "TFS Deployer: $_comment"
	$_dbi.history = $_relComment
	
	if ($_dbi.Fields["HIC Build Numbers"].Value -eq $null)
	{
		$_dbi.State = "Deployed"
	}
	else
	{
		$_dbi = update-DeploymentStatus $_dbi
		$_dbi = check-State $_dbi
	}
	
	$_dbi.Save()
	$deployer.Logger.Log("Update complete", "debug")
}

function check-State ($dbi)
{
	$deployer.Logger.Log("Checking deployment statuses of DBI", "debug")
	
	[string] $buildStatus = "HIC Build Package# Deployment Status"
	[int] $maxCount = $($($dbi.Fields["HIC Build Numbers"].Value).split(",")).Count
	[bool] $allDeployed = $true
	[int] $one = 1
	
	for ($i = 1; $i -le $maxCount; $i++)
	{
		$bs = $buildStatus -replace "#", $i
		
		if ($dbi.Fields[$bs].Value -ne $one)
		{
			$allDeployed = $false
			break;
		}
	}
	
	if ($allDeployed)
	{
		$dbi.State = "Deployed"
	}
	
	return $dbi
}

function update-DeploymentStatus ($dbi)
{
	$deployer.Logger.Log("updating deployment status of DBI", "debug")
	[string] $buildName = "HIC Build Package#"
	[string] $buildStatus = "HIC Build Package# Deployment Status"
	[int] $maxCount = $($($dbi.Fields["HIC Build Numbers"].Value).split(",")).Count
	[int] $one = 1
	
	for ($i = 1; $i -le $maxCount; $i++)
	{
		$bn = $buildName -replace "#", $i
		$bs = $buildStatus -replace "#", $i
		
		if ($i -eq 1)
		{
			$bn = "Build Number"
		}
		
		if ($dbi.Fields[$bn].Value -eq $deployer.BuildData.BuildNumber)
		{
			$dbi.Fields[$bs].Value = $one
			break;
		}
		
	}
	
	return $dbi
}

function get-DBIQuery ([string] $_buildNumber, [string] $_teamProject, [string] $_targetEnv)
{
"SELECT [System.ID]
FROM WORKITEMS
WHERE ([HIC.Build.Numbers] CONTAINS '$_buildNumber'
AND
[System.TeamProject] == '$_teamProject'
AND
[HIC.Test.Environment.New] == '$_targetEnv'
AND
[STATE] CONTAINS 'Approved'
AND
[System.WorkItemType] == 'Deployment Backlog Item')"
}

###MAIN###
# First check to see if our xml file exists 
$deployer.Logger.Log("checking to see if any work items need to be updated", "Config")

$environment = $deployer.env

if ($environment.Contains("-"))
{
	$environment = $($environment.split('-')[1])
}

$deployer.Logger.Log($("Split ENV => " + $deployer.env + " to " + $environment), "Debug")

if ($environment.Equals("PrePrd"))
{
	$environment = "Pre-Prd"
}

$deployer.Logger.Log("Fetching Config info", "Debug")

$config = [xml] $(get-content .\TFSDeployerScripts\Config.xml)

$deployer.Logger.Log("Config XML Fetch complete", "debug")

$tfs = .\Get-Tfs.ps1 $config.Deployment.TFSServerUrl

$deployer.Logger.Log($("TFS connect completed`n Connected to: " + $config.Deployment.TFSServerUrl), "debug")


$wixmlpath = $deployer.BuildData.DropLocation + "\BuildWorkItemNumber.xml"
$isThere = (resolve-path $wixmlpath -ea silentlycontinue).path
$deployer.Logger.Log("Checking for Build XML", "debug")

#[Microsoft.TeamFoundation.WorkItemTracking.Client.WorkItem] $wi

if ($isThere)
{
	$deployer.Logger.Log("Found Build XML", "debug")
	[XML] $wixml = get-content $wixmlpath
	$deployer.Logger.Log($("WI XML fetched BBI# " + $wixml.project.build.workitemnumber), "debug")
	$wi = $tfs.wit.getworkitem($wixml.project.build.workitemnumber)
	$deployer.Logger.Log($("Updating work item # " + $wixml.project.build.workitemnumber), "debug")
}
else
{
	#no BBI need to look for DBI 
	[string] $query = get-DBIQuery $deployer.BuildData.BuildNumber $config.Deployment.DBITeamProject $environment
	
	$deployer.Logger.Log($("Querying workitems:`n" + $query), "debug")
	$results = $tfs.wit.Query($query)
	
	if ($results.Count -eq 1)
	{
		$deployer.Logger.Log($("DBI found " + $results.Item(0).ID), "info")
		$wi = $results.Item(0)
	}
	else
	{
		$deployer.Logger.Log($("Could not find a single DBI for this deployment"), "warning")
		return 
	}

}

$wi.open()
$date = get-date
$historyComment = get-historycomment
$comment = $deployer.BuildData.BuildNumber + " was moved to " + $deployer.env + " at  $date $historyComment"
$wi.history = $comment

if ($wi.Type.Name -eq "Build Backlog Item")
{
	$wi.Fields["HIC Current Test Env"].Value = $environment
}
elseif ($wi.Type.Name -eq "Deployment Backlog Item")
{
	$wi = update-DeploymentStatus $wi
	$wi = check-State $wi
}

$wi.save()
$deployer.Logger.Log($("Update complete:`n" + $comment), "config")
update-RelatedWorkItems $tfs $wi $comment
