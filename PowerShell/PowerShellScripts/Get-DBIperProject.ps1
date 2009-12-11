#Get-DBIperProject 
#this script will return a list of DBI for a particular project 

param([string] $projName = $(throw 'DBi project name is required'),
      [bool] $getAll = $($false))

function get-AppDBIQuery ([string] $_proj)
{
"SELECT [System.ID], [HIC.Project], [HIC.Test.Environment.New], [System.CreatedBy]
FROM WORKITEMS
WHERE ([HIC.Project] CONTAINS '$_proj'
AND
[STATE] CONTAINS 'Approved'
AND
[System.WorkItemType] == 'Deployment Backlog Item')"
}

function get-AllDBIQuery ([string] $_proj)
{
"SELECT [System.ID], [HIC.Project], [HIC.Test.Environment.New], [System.CreatedBy]
FROM WORKITEMS
WHERE ([HIC.Project] CONTAINS '$_proj'
AND
[System.WorkItemType] == 'Deployment Backlog Item')"
}

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 


pushd $(Split-Path $(get-script) -Parent)

$tfs = .\get-tfs.ps1 

if ($getAll)
{
	$results = $tfs.wit.Query($(get-AllDBIQuery $projName))
}
else
{
	$results = $tfs.wit.Query($(get-AppDBIQuery $projName))
}

if ($results.count -gt 0) 
{
	[array] $list = @()
	
	$results | %{
	$obj = new-object Object
	
	$obj | Add-Member -MemberType NoteProperty -Name "ID" -Value $_.ID
	
	$obj | Add-Member -MemberType NoteProperty -Name "TargetEnv" -Value $_.Fields["New Test Environment"].value
	
	$obj | Add-Member -MemberType NoteProperty -Name "State" -Value $_.State
	
	$obj | Add-Member -MemberType NoteProperty -Name "CreatedBy" -Value $_.CreatedBy
	
	$list += $obj 
	
	}
	
	$list | Format-Table
}
else
{
	write-host -ForegroundColor yellow "There are no approved Items for $projName in Deployment Backlog"
}