#############################
#Generate-TfsCLPortalEarBuildPackage
#This script will be called the CLPortal Ant script it will import the 
#new created EAR file into TFVC then kick off the SRM.CLPORTAL.EAR.Release 
#Build Type.  This will create a build package shell which will then be 
#Populated with the EAR, once populated this script may kick off a deployment
##############################

Param([string] $earFileName = $(throw 'Error: The Ear file name is Required'),
      [string] $share = $(throw 'Error: The full UNC path to shared dir where the EAR file is Required'),
      [string] $buildType = $(throw 'Error: The Build Type Name is Required'),
      [string] $EarType = $(throw 'Error: The Ear type is Required ex/CLFA, CLHIIS02' ),
      [string] $deployBQ = $("Unexamined"),
      [string] $teamProject = $("HIC.Projects"),
      [string] $importEar2TFVC = $("false"),
      [string] $buildPath = $("E:\Builds\EAR"))

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

###MAIN###

Push-Location -Path (Split-path $(get-script))

[string] $path2Ear = Join-Path $share $earFileName

Write-host "Importing $path2Ear to TFVC"

[bool] $importalResults = $true

if ($importEar2TFVC -eq "true")
{
	$importalResults = .\Import-EAR.ps1 $path2Ear
}

if ($importalResults)
{
	Write-Host "Kicking off Build SRM.CLFA.EAR.Release"
	[string] $buildUri = .\Start-TeamBuild.ps1 $teamProject $buildType $buildPath
	
	#[string] $buildUri = "vstfs:///Build/Build/06052008_202617_72069"
	
	$tfs = ..\Get-Tfs.ps1
	
	$buildData = $tfs.TBP.GetBuildDetails($buildUri)
	
	[int] $sleepCount = 0
	
	do
	{
		if ($sleepCount -gt 12)
		{
			throw "Error: Build Compile time over 120 seconds, please review"
		}
		
		sleep -Seconds 10
		
		$buildData = $tfs.TBP.GetBuildDetails($buildUri)
		
		$sleepCount++
		
		if ($buildData.BuildQuality -eq "Rejected")
		{
			throw "Error: Build failed to build"
		}
		
	}until ($buildData.BuildStatus -eq "Successfully Completed")
	
	Write-Host " $($buildData.BuildNumber) Successfully Completed"
	
	[string] $earFolderPath = Join-Path $buildData.DropLocation $EarType
	
	New-Item -Path $($buildData.DropLocation) -Name $EarType -ItemType Directory | out-null
	
	Copy-Item -path $path2Ear -Destination $earFolderPath | out-null
	
	if ($deployBQ -ne "Unexamined")
	{
		Write-Host "Requesting Deployment to $($deployBQ.Split("-"))[1]"
		$tfs.TBP.UpdateBuildQuality($('vstfs:///Build/Build/' + $buildDate.BuildUri), $deployBQ)
		Write-Host "TFS Deployer will email you with deployment results"
	}
	
}
else
{
	throw "Error: Error during import of $path2Ear to TFVC"
}

return $true