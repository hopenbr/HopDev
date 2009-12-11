#####################################################
#Ear File Importer 
#created to be run to import EAR into TFVC and kick off a teambuild to 
#get automated deployment of EAR files for J2EE WebSphere 
#
#This is name of  most recent build - it is on Build machine W73hic400187 in 
#folder deploy
#EAR file name is  - CLPortal_R2_0_04_14_2008_11_17.ear 
#              R2_0  - is the Release number and has only changed once from R1_0
#              04_14_2008  is the date of the build 
#              11_17  is the time of the build
# 
#when we deploy we deploy from the build machine!    
#Link below is to the current build on build machine
# 
#Location -  \\W73hic400187\deploy\CLPortal_R2_0_04_14_2008_11_17.ear
# 
#Some previous Build Names 
# CLPortal_R2_0_04_04_2008_08_36.ear 
# CLPortal_R2_0_04_03_2008_03_22.ear  
# CLPortal_R2_0_04_01_2008_09_39.ear
# 
#####################################################

param ([string] $path2Ear = $(throw 'Full UNC path to EAR file is required'),
	   [string] $serverPathBase = $("$/HIC.Projects/EAR"))

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

function parse-BuildNumber ([string] $buildNumber)
{
	[hashtable] $bn = @{}
	
	#CLPortal_R2_0_06_14_2008_08_36.ear
	#  0       1 2  3  4  5   6   7
	
	[Array] $temp = $buildNumber.split("_")
	
	if ($temp.Length -ne 8)
	{
		throw "Error: Ear file `($buildNumber`) name not in correct format"
	}
	
	#kill extention
	$temp[7] = $temp[7].split(".")[0]
	
	$bn["Name"] = $temp[0]
	
	$bn["Version"] = $temp[1] + "." + $temp[2]
	
	[string] $ts = $temp[3] + "/" + $temp[4] + "/" + $temp[5] + " " + $temp[6] + ":" + $temp[7]
	
	$bn["Timestamp"] = [datetime] $ts
	
	$bn["Year"] = $temp[5]
	
	$bn["Month"] = $temp[3]
	
	return $bn
}

function get-ServerPath ($vcs, [string] $month, [string] $year)
{
	
}

###MAIN###

Push-Location (Split-Path $(get-script))

[datetime] $date = get-date

[hashtable] $rel = parse-BuildNumber $(Split-Path $path2Ear -Leaf)

#create TFVC workspace for import

$tfs = ..\get-tfs.ps1

$ws = $tfs.VCS.CreateWorkspace("EAR_Import_" + $date.ToString("yyyyMMddhhmmss"))

[string] $localBasePath = $(Join-path $env:temp $ws.Name)

[string] $localPath = $localBasePath

[string] $localDest = $localBasePath 

$getReq = New-Object Microsoft.TeamFoundation.VersionControl.Client.GetRequest($serverPathBase, [Microsoft.TeamFoundation.VersionControl.Client.RecursionType]::None, [Microsoft.TeamFoundation.VersionControl.Client.LatestVersionSpec]::Latest)

if ($tfs.vcs.ServerItemExists($serverPathBase + "/" + $rel.Name + "/" + $rel.Version + "/" + $rel.Year + "/" + $rel.Month + "/" + $(split-path $path2Ear -Leaf), [Microsoft.TeamFoundation.VersionControl.Client.ItemType]::File))
{
	write-debug "$path2Ear already in TFVC"
	return $true
}

if ($tfs.vcs.ServerItemExists($serverPathBase + "/" + $rel.Name + "/" + $rel.Version + "/" + $rel.Year + "/" + $rel.Month, [Microsoft.TeamFoundation.VersionControl.Client.ItemType]::Folder))
{
	[string] $mapPath = $($serverPathBase + "/" + $rel.Name + "/" + $rel.Version + "/" + $rel.Year + "/" + $rel.Month)
	$ws.Map($mapPath, $localPath)
	$getReq = New-Object Microsoft.TeamFoundation.VersionControl.Client.GetRequest($mapPath, [Microsoft.TeamFoundation.VersionControl.Client.RecursionType]::None, [Microsoft.TeamFoundation.VersionControl.Client.LatestVersionSpec]::Latest)
}
elseif($tfs.vcs.ServerItemExists($serverPathBase + "/" + $rel.Name + "/" + $rel.Version + "/" + $rel.Year, [Microsoft.TeamFoundation.VersionControl.Client.ItemType]::Folder))
{
	$localDest += "\" + $rel.Month
	[string] $mapPath = $($serverPathBase + "/" + $rel.Name + "/" + $rel.Version + "/" + $rel.Year)
	$ws.Map($mapPath, $localPath)
	$getReq = New-Object Microsoft.TeamFoundation.VersionControl.Client.GetRequest($mapPath, [Microsoft.TeamFoundation.VersionControl.Client.RecursionType]::None, [Microsoft.TeamFoundation.VersionControl.Client.LatestVersionSpec]::Latest)
}
elseif($tfs.vcs.ServerItemExists($serverPathBase + "/" + $rel.Name + "/" + $rel.Version, [Microsoft.TeamFoundation.VersionControl.Client.ItemType]::Folder))
{
	$localDest +=  "\" + $rel.Year + "\" + $rel.Month
	[string] $mapPath = $($serverPathBase + "/" + $rel.Name + "/" + $rel.Version)
	$ws.Map($mapPath, $localPath)
	$getReq = New-Object Microsoft.TeamFoundation.VersionControl.Client.GetRequest($mapPath, [Microsoft.TeamFoundation.VersionControl.Client.RecursionType]::None, [Microsoft.TeamFoundation.VersionControl.Client.LatestVersionSpec]::Latest)
}
elseif($tfs.vcs.ServerItemExists($serverPathBase + "/" + $rel.Name, [Microsoft.TeamFoundation.VersionControl.Client.ItemType]::Folder))
{
	$localDest +=  "\" + $rel.Version + "\" + $rel.Year + "\" + $rel.Month
	[string] $mapPath = $($serverPathBase + "/" + $rel.Name + "/" + $rel.Version)
	$ws.Map($mapPath, $localPath)
	$getReq = New-Object Microsoft.TeamFoundation.VersionControl.Client.GetRequest($mapPath, [Microsoft.TeamFoundation.VersionControl.Client.RecursionType]::None, [Microsoft.TeamFoundation.VersionControl.Client.LatestVersionSpec]::Latest)
}
else
{
	$localDest += "\" + $rel.Name + "\" + $rel.Version + "\" + $rel.Year + "\" + $rel.Month
	$ws.Map($serverPathBase, $localPath)
}

$ws.Get($getReq, [Microsoft.TeamFoundation.VersionControl.Client.GetOptions]::None) | out-null

#Workspace is ready for import
#get Ear to local workspace for import

if (!(Test-Path $localDest)) 
{
	New-Item -Path $localBasePath -ItemType Directory -Name $($rel.Name + "\" + $rel.Version + "\" + $rel.Year + "\" + $rel.Month) | out-null
}

Copy-Item -Path $path2Ear -Destination $localDest -Force

$ws.PendAdd((Join-Path $localDest (split-path $path2Ear -Leaf))) | out-null

$results = $ws.CheckIn($ws.GetPendingChanges(), "Import of Ear file")

if ($($ws.GetPendingChanges()).Count -gt 0)
{ #bool noActionNeeded is a false positive there if true actions are needed
	$ws.Undo($ws.GetPendingChanges())
}

$ws.Delete() | out-null

gci $localDest -Recurse | Remove-Item -Force 

if (!$($results -gt 0))
{
	Write-Warning "Warn: There was a exception (conflict) when attempting to add $path2Ear to TFVC"
	return $false
}

return $true