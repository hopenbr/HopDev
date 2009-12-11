##This scripts will run the specified cmd that invokes the Stsadm 

#Param will be set globally by Harleysville.Powershell.Utilities 
#This script is designed to be run as part of the Stsadm services web service 
#to test locally un comment below param cmd 

#param($batName = $(throw 'The batch file name that needs to be called is required'),
	   $parameters = $(throw 'A string of space delimited batch file parameters is required')) 

function get-ScriptLocation()
{
	if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   	else { $myInvocation.MyCommand.Definition }
}

Set-Location $( split-path (get-ScriptLocation) -parent)
$location = $(pwd)

[string] $batFile = (join-path $location.Path $batName) 

$results = cmd /c $cmd $batFile $parameters

return $results
