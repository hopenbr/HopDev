param(
	[string] $Build = $(throw 'Build (Either build number or build URI) is required'),
    [string] $NewQuality = $(throw 'New Quality required'),
    [string] $tp,    
    [string] $buildType  
)

trap 
{
	$script = get-script
	$msgLog = "Error trapped in $script`n`n$_"
	$script_folder = split-path $script
	Push-Location $script_folder
	.\Write-EventLog.ps1 $msgLog "Harleysville.BuildQualityEditor" "4202" "Error";
	break;
} 

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

function write-InfoLog ([string] $_msg)
{
    .\Write-EventLog.ps1 $_msg "Harleysville.BuildQualityEditor" "4200"
}

function update-Uri
{
	if (!$buildUri.Contains("vstfs:///"))
	{
		$BuildUri = 'vstfs:///Build/Build/' + $BuildUri
	}
	
	$tfs.TBP.UpdateBuildQuality($BuildUri, $NewQuality)
	write-InfoLog "$BuildUri updated to $NewQuality"
}

function update-BuildNumber
{
	$BuildUri = $tfs.TBP.GetBuildUri($tp, $BuildNumber)

	$tfs.TBP.UpdateBuildQuality($BuildUri, $NewQuality)
	
	write-InfoLog "$BuildNumber updated to $NewQuality"
}

function update-PreviousBuilds
{
	write-InfoLog "Checking for previous build in same state"
	if ($buildType -and $tp)
	{
		$prevBuilds = $tfs.TBP.GetListOfBuilds($tp, $buildType)
		[string] $rollBackBuilds
		foreach ($build in $prevBuilds)
		{		
			if ($build.BuildQuality.Contains($NewQuality))
			{
					if($NewQuality.Equals("In-Production"))
					{
						$changeQualityTo = "Released"
					}
					else
					{
						$changeQualityTo = "Rejected"
					}
						
					$tfs.TBP.UpdateBuildQuality($build.BuildUri, $changeQualityTo) | out-null
					
					$rollBackBuilds += $build.BuildUri + ";"
			}
		}
		if ($rollBackBuilds)
		{
			save-4Rollback $rollBackBuilds.Trim(";")
		}
	}
	write-InfoLog "Finished check for previous build"
}

function save-4Rollback ([string] $_buildUri)
{
	write-InfoLog "Saving last build for roll Back"
	
	if ($TFSDeployerBuildData.DropLocation)
	{
		if ($_buildUri.Split(";").Count -eq 1)
		{
			$dropPath = $TfsDeployerBuildData.DropLocation + "\RollBack.xml"
			$rollBackxml = "<?xml version=`"1.0`" ?>`n<Project>`n`t<Rollback>`n`t`t<BuildUri>$_buildUri</BuildUri>`n`t</Rollback>`n</Project>"
			$rollBackxml > $dropPath
		}
	}
}

##MAIN##
#Getting location of script running and then cd to it
$script = get-script
$script_folder = split-path $script
Push-Location $script_folder
$config = [xml] $(get-content .\Config.xml)

write-InfoLog "Build Quality Editor started"
$tfs = .\Get-Tfs.ps1 $config.Powershell.TFSServerUrl

if ($NewQuality -ne "In-Error")
{
	update-PreviousBuilds
}

if ($($Build.split("="))[0] -ieq "/BuildNumber")
{
	$BuildNumber = $($Build.split('='))[1]
	if(! $tp)
	{
		throw "The team project name is require if you are passing the BuildNumber in"
	}
	update-BuildNumber
}
else
{
	$BuildUri = $($Build.split('='))[1]
	update-Uri
}

Pop-Location
##Pop back to original location before returning
##I am not sure if this matter b/c I think a new shell is 
##open on scripts calls but I am unsure right now