
function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
} 

pushd $(Split-path $(get-Script) -Parent) 

Read-Host -Prompt "Region Name (ie ASY, E2E, etc)" -OutVariable r
Read-Host -Prompt "Action(Start/Stop)" -OutVariable a

New-Variable -Name cp -Value ".\AQSServices.xml"

if (-not (Test-Path $cp))
{
	do 
	{
		Read-Host -Prompt "Full UNC path to config (q to quit)" -OutVariable c
	} until ((Test-Path $c) -or $c -eq "q")
	
	$cp = $c
}


$res = .\set-AQSServices.ps1 $cp $r $a

