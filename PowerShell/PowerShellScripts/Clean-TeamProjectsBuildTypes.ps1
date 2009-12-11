param([string] $teamProj = $(throw 'The Team Project name is required'))

function get-script
{
if($myInvocation.ScriptName) { $myInvocation.ScriptName }
else { $myInvocation.MyCommand.Definition }
}


###MAIN####
[void] [Reflection.Assembly]::LoadWithPartialName("Microsoft.TeamFoundation.VersionControl.Client")


pushd $(Split-Path (get-script) -Parent)

$tfs = .\Get-TFS.ps1

$buildtypes = $tfs.vcs.GetItems("`$/$teamproj/TeamBuildTypes/*").Items  | 
	%{ (Split-path $_.ServerItem -leaf)}
	

foreach ($bt in $buildtypes)
{
	.\Clean-TeamBuildTypes.ps1 $teamProj $bt -listOnly
}

popd