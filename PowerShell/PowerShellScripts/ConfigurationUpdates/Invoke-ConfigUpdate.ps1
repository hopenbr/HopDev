param([string] $path2list = $(throw 'ERROR: Full UNC path to file list is required '))


function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

####MAIN####

pushd $(Split-Path $(get-Script) -Parent)

$snr = gi ..\Invoke-SearchAndReplace.ps1 

[hashtable] $srnTable = @{"as73esbe2e01:5555" = "ewse2e";
						 "ewse2e.harleysvillegroup.com:5555" = "ewse2e";
						 "ewse2e:5555" = "ewse2e"}
						 
						 

foreach($set in $(gc $path2list))
{
	ls $set | & $snr $srnTable
	
}