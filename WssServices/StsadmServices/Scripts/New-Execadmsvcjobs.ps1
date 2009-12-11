#new-execadmsvcjobs
#this script will return an object that can run the .\stsadm.exe -o execadmsvcjobs operation
#this script assume you are in the 12-hive bin 


##MAIN##
[Object] $exec = New-Object Object

$exec | Add-Member -MemberType NoteProperty -Name "Results" -Value ""

$exec | Add-Member -MemberType NoteProperty -Name "ExitCode" -Value $(0 -as [int])

$exec | Add-Member -MemberType ScriptMethod -Name "Run" -Value  {$res = "<Result cmd=`"execadmsvcjobs`">"
	$res += .\stsadm.exe -o execadmsvcjobs 2>&1
	$res += "</Result>"
	
	$this.ExitCode = $lastexitcode
	
	if ($this.ExitCode -ne 0)
	{
		$this.Results =  $($res + "<Error>ERROR: Could not run execadmsvcjobs</Error></Results>")
	}
	else
	{
		$this.Results = $res
	}
} #end Run scriptblock

return  $exec
