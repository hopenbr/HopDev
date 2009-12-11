#Load-Tools 
#This script will return a tools obj that has all the paths to exe 
# that HPP using there is will be a config file as well for the paths 

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

###MAIN### 

$hppTools = New-Object -TypeName Object

[xml] $config = [xml] $(gc $((get-script) + ".config"))

foreach ($tool in $config.configuration.appSettings.add)
{
	$hppTools | Add-Member -MemberType NoteProperty -Name $tool.key -Value $(get-item $tool.value)
}

return $hppTools
