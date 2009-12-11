##Run-StsadmCmd is a script that will run any stsadm cmd passed in 
#This scitp is designed to via the StsadmService Web services 
#the service with populate the $cmd as a global variable before is invokes this script
#to debug locally uncomment out on the param cmd

#param([string] $cmd = $(throw 'The stsadm cmd string is required'),
#      [string] $stsadmDir = $("C:\Program Files\Common Files\Microsoft Shared\web server extensions\12\BIN"))

pushd $stsadmDir
[string] $results = ""

if ($cmd.Contains("stsadm"))
{
	[string] $cmds = $cmd -replace "^(.*?-){1}", " -"
	$results = invoke-expression $(".\stsadm.exe " + $cmds)
}
else
{
	$results = "Error: Non-cmd passed in. $cmd is not an Stsadm cmd "
}

popd 

return $results