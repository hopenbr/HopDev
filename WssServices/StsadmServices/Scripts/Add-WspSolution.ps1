##Add-WspSolution is a script that will run add a wsp solution to local MOSS/WSS server 
#via stsadm cmd  
#This scitp is designed to via the StsadmService Web services 
#the service with populate the parameters as global variables before is invokes this script
#to debug locally uncomment out on the param cmd

#param([string] $wspFile = $(throw 'The full UNC path to wsp file is required including extention'),
#	   [string] $sleepTime = $(30),
#      [string] $stsadmDir = $("C:\Program Files\Common Files\Microsoft Shared\web server extensions\12\BIN"),
#	   [string] $debug = $("false"),
#	   [string] $forceWspDeploy = $("false")
#	   [string] $siteUrl = $('') )


function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}


###MAIN###

$execAdm = Get-item $(Join-Path $(Split-Path $(get-script) -Parent) "new-Execadmsvcjobs.ps1")

[Object] $execadmsvcjobs = & $execAdm

pushd $stsadmDir

[string] $results = "<Results>"

[string] $wspFileName = $(Split-path $wspFile -leaf)

#check see if solution has already been deployed 

[string] $solutions = .\stsadm.exe -o enumsolutions 

if ($debug -eq "true")
{
	$results += "<Debug>"
	$results += "WSP: $wspFileName"
	$results += "</Debug>"
	#$results += "<Debug>"
	#$results += "Solutions: $solutions"
	#$results += "</Debug>"
}

[bool] $isXml = $false
[bool] $isWspAlreadyThere = $false

if ($lastexitcode -ne 0)
{
	return $($results + "<Error>ERROR: Could not get solutions enum xml</Results>")
}

[bool] $useUrl = $false

if ($siteUrl.length -gt 0)
{
	$useUrl = $true
		
	if ($debug -eq "true")
	{
		$results += "<Debug>"
		$results += "URL: $siteUrl"
		$results += "</Debug>"
	}
}


if ($solutions.Contains("</Solutions>"))
{
	if ($debug -eq "true")
	{
		$results += "<Debug>"
		$results += "Solution XML verified; setting Xml"
		$results += "</Debug>"
	}
	
	[xml] $solXml = $solutions
	$isXml = $true
}

if ($isXml)
{
	if ($solXml.solutions.SelectSingleNode("Solution[@Name='$($wspFileName.ToLower())']"))
	{
		$isWspAlreadyThere = $true
	}

}


if ($isWspAlreadyThere -and
    $forceWspDeploy -eq "false"  )
{
	$results += "<Result cmd=`"upgradesolution`">"
	$results += .\stsadm.exe -o upgradesolution -name $wspFileName -filename $wspFile -immediate -allowgacdeployment 2>&1
	$results += "</Result>"
	
	if ($lastexitcode -ne 0)
	{
		return $($results + "<Error>ERROR: Could not Upgrade solution</Error></Results>")
	}
	
	$execadmsvcjobs.Run()
	
	if ($execadmsvcjobs.ExitCode -ne 0)
	{
		return $($results + $execadmsvcjobs.Results)
	}
	else
	{
		$results += $execadmsvcjobs.Results
	}
	

}
elseif ($isWspAlreadyThere -and
        $forceWspDeploy -eq "true"  )
{
	if ($debug -eq "true")
	{
		$results += "<Debug>"
		$results += "Running retracted solution"
		$results += "</Debug>"
	}
	
	$results += "<Result cmd=`"retractsolution`">"

	$results += .\stsadm.exe -o retractsolution -name $wspFileName -immediate -allcontenturls 2>&1
	
	$results += "</Result>"
	
	if ($lastexitcode -ne 0)
	{
		return $($results + "<Error>ERROR: Could not retract solution</Error></Results>")
	}
	
	$execadmsvcjobs.Run()
	
	if ($execadmsvcjobs.ExitCode -ne 0)
	{
		return $($results + $execadmsvcjobs.Results)
	}
	else
	{
		$results += $execadmsvcjobs.Results
	}
	
	if ($debug -eq "true")
	{
		$results += "<Debug>"
		$results += "Sleeping for $sleepTime seconds"
		$results += "</Debug>"
		$results += "<Debug>"
		$results += "Running deleted solution"
		$results += "</Debug>"
	}
	
	sleep -seconds $sleepTime
	
	$results += "<Result cmd=`"deletesolution`">"
	$results += .\stsadm.exe -o deletesolution -name $wspFileName -override 2>&1
	$results += "</Result>"
	
	if ($lastexitcode -ne 0)
	{
		return $($results + "<Error>ERROR: Could not delete solution</Error></Results>")
	}
	
	$execadmsvcjobs.Run()
	
	if ($execadmsvcjobs.ExitCode -ne 0)
	{
		return $($results + $execadmsvcjobs.Results)
	}
	else
	{
		$results += $execadmsvcjobs.Results
	}
}

if ($forceWspDeploy -eq "true" -or
    !$isWspAlreadyThere)
{
	if ($debug -eq "true")
	{
		$results += "<Debug>"
		$results += "Running add solution"
		$results += "</Debug>"
	}

	$results += "<Result cmd=`"addsolution`">"
	$results += .\stsadm.exe -o addsolution -filename $wspFile 2>&1
	$results += "</Result>"


	if ($lastexitcode -ne 0)
	{
		return $($results + "<Error>ERROR: Could not add solution</Error></Results>")
	}
	
	$execadmsvcjobs.Run()
	
	if ($execadmsvcjobs.ExitCode -ne 0)
	{
		return $($results + $execadmsvcjobs.Results)
	}
	else
	{
		$results += $execadmsvcjobs.Results
	}

	if ($debug -eq "true")
	{
		$results += "<Debug>"
		$results += "Running deploy solution"
		$results += "</Debug>"
	}


	$results += "<Result cmd=`"deploysolution`">"
	if ($useUrl)
	{
		$results += .\stsadm.exe -o deploysolution -name $wspFileName -allowgacdeployment -immediate -url $siteUrl -force 2>&1
	}
	else
	{
		$results += .\stsadm.exe -o deploysolution -name $wspFileName -allowgacdeployment -immediate -force 2>&1
	}
	$results += "</Result>"

	if ($lastexitcode -ne 0)
	{
		return $($results + "<Error>ERROR: Could not deploy solution</Error></Results>")
	}
	
	$execadmsvcjobs.Run()
	
	if ($execadmsvcjobs.ExitCode -ne 0)
	{
		return $($results + $execadmsvcjobs.Results)
	}
	else
	{
		$results += $execadmsvcjobs.Results
	}
}

popd 

$results += "</Results>"

return $results