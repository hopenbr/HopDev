param(
	[regex] $regex = $(throw 'Regex is required'),
    [string] $file = $(throw 'Full path to file is required'),
    [string] $replace = $(throw 'replacement string is required')
)

trap { throw-error $_.Exception $_.Exception.GetType().Name; break; }   
function throw-error                                                                                             
{                                                                                                                                                                                                                                  
	throw("Error: $args[1]`n $args[0]")
} 

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

#Getting location of script running and then cd to it
$script = get-script
$script_folder = split-path $script
push-location $script_folder


$content = [string]::join([environment]::newline, (get-content -path $file))

$regex.replace($content, $replace) | set-content $file
