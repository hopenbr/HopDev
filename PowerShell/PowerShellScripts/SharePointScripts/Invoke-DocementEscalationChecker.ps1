##invoke-DocumentEscalationChecker
#this script will search a document library and check for 
#stale documents that needs escalation via the doc escalation workflow
#Doc Escalation workflow needs to be enabled on the Document Library

param([string] $docLibUrl = $(throw 'Full URL to Document Library is required'),
      [string] $docLibName = $(throw 'The name of the Document libriary is required'),
	  [string] $docEscalationWorkflowName = $(throw 'The name of the doc escalation workflow is required'))


##Using

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint") > $null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Deployment") > $null

##PSH Variables

$ErrorActionPreference = "Stop"
$DebugPreference = "Continue"


###MAIN

$site = new-object Microsoft.SharePoint.SPSite($docLibUrl)
	
$web = $site.OpenWeb()

$dl = $web.lists[$docLibName]

Write-Debug $("Open DocLib: " + $dl.Title)

foreach ($item in $dl.items)
{
	Write-Debug $("Testing: " + $item.name )
	
	$lastMod = $item.fields["Modified"].PreviewValueTyped
	
	$ts = New-TimeSpan -Start $lastMod -End $(get-date)
	
	if ($DebugPreference -eq "Continue")
	{
		Write-Debug "Timespan info: "
		$ts 
	}
	
	if ($ts.Days -gt 181)
	{
		Write-Debug "Escalation needed" 
		
		foreach ($awf in $dd.WorkflowAssociations)
		{
			if ($awf.Name -eq $docEscalationWorkflowName)
			{
				Write-Debug "Calling $docEscalationWorkflowName workflow"
				
				$site.WorkflowManager.StartWorkflow($item, $awf, $awf.AssocaitionData, $true) | Out-Null
				
				break
			}
		}


	}
	else
	{
		break
	}
	
	
}



$web.Dispose()

$site.Dispose()