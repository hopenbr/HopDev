trap 
{
	$script = get-script
	$msgLog = "Error trapped in $script`n`n$_.Exception"
	$script_folder = split-path $script
	Push-Location $script_folder
	..\Write-EventLog.ps1 $msgLog $config.Deployment.EventSource $eventLogErrorNumber "Error";
	break;
} 

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 

$replacementValues = @{}

$replacementValues."In-Assembly" = "TX2050ASY"
$replacementValues."In-SystemTest01" = "TX2050QA1"
$replacementValues."In-SystemTest02" = "TX2050QA2"
$replacementValues."In-End2End" = "TX2050EEIT"
$replacementValues."In-Dev" = "TX2050"

$child = get-childitem *.bat -path $path

foreach ( $bat in $child )
{
	.\Replace-Infile "TX2050.?" $bat.get_FullName() $replacementValues[$env]
}