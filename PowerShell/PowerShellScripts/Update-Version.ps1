param(
	[string] $buildNumber = $(throw 'BuildNumber is required'),
    [string] $path = $(throw 'Full path to version.ascx')
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

$regexBuildNumber = [regex] "v([0-9]+\.)+[0-9]+"
$regexProj = [regex] "[A-z]+-"
$regexNewLine = [regex] ">\ +<"

$BuildNumber = $regexProj.Replace($buildNumber, "v");
#this should take BN from project-1.0.0.1 to v1.0.0.l

$versionPage = get-content $path
#getting the version.ascx page 

$versionPage = $regexBuildNumber.Replace($versionPage, $buildNumber) 
#replace the old version number in version.ascx w/ the new one

$regexNewLine.Replace($versionPage, ">" + [environment]::newline  +  "<") | set-content $path
#get-content doesn't return new lines, therefore I have put them back
#this only works b/c version.ascx is so very simple there are only two lines of code.