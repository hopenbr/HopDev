param( [string] $testBuild2Use = $(throw 'The Test build number is required'),
		[string] $TeamProject = $(throw 'The Team project that the build is in is required'),
		[string] $BuildType = $(throw 'The Build type is required'))

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 

function throw-usage ([string] $err)
{
	[string] $use = "This script is writen with the intention to used to test the Deployer locally."
				  + " This script will return the equivelent of the \$TFSDeployerBuildData object for "
				  + "the build package of your choose.'n'n"
				  + ".\Set-Testbed <[string] Build Package Number> <[string] Team Project> <[string] Team Build type>"
	
	throw "Error: $err`n`n Usage:`n$use"
}

$script = get-script
$script_folder = split-path $script
Push-Location $script_folder 
$config = [xml] $(get-content ..\config.xml)
$tfs = ..\..\Get-TFS.ps1 $config.Deployment.TFSServerUrl
$builds = $tfs.TBP.GetListOfBuilds($TeamProject, $BuildType)

#$Drive = "E:"
#$UNC = "\\as73tfsbuild01\e$"
#$net = New-Object -com WScript.Network; 
#$net.mapnetworkdrive($Drive,$UNC)

foreach ($build in $builds)
{
	if ($build.BuildNumber -eq $testBuild2Use)
	{
		$build.LastChangedBy = [Security.Principal.WindowsIdentity]::GetCurrent().Name
		if (!$build.TeamProject)
		{
			$build.TeamProject = $TeamProject
		}
		return $build
	}
}

#$net.removenetworkdrive($Drive)
throw "Error: Could not find Test bed build ($testBuild2Use)"