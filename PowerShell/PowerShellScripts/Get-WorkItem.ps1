param(
    [int] $wiNum = $(throw 'Workitem number is required'),
    $tfs = $null
)

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

set-psdebug -strict

$script = get-script
$script_folder = split-path $script
Push-Location $script_folder
if ($tfs -eq $null)
{
	$tfs = .\Get-tfs.ps1 "Http://as73tfs01:8080"
}

return $tfs.WIT.GetWorkItem($wiNum)