##Add-InfoPathForm 
#this script will added the compiled info path form to local MOSS server 
#and activates that form for passed in Site (URL) 
#
#this script will return results xml 
#This script is designed to be run via the stsadmService web service app, to test locally you will
#need to uncomment the below parameters else wise these all parameters are set as global varibles 
#by the parent web method

#param([string] $path2Xsn = $(throw 'The full UNC path to info path xsn file is required including extention'),
#	   [string] $sleepTime = $(30),
#      [string] $stsadmDir = $("C:\Program Files\Common Files\Microsoft Shared\web server extensions\12\BIN"),
#	   [string] $mossUrl = $("http://as73mossdev01:24921/sites/Agent/Pages/Agent_Home.aspx"),
#	   [string] $xsnSha1 = $(),
#	   [string] $debug = $("false"),
#	   [string] $forceInfoPathDeploy = $("false"),
#	   [string] $verifyInfoPathForms = $("false"))


function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

###MAIN###

#Getting the scripts I will be invoking later
 
$csha1 =  Get-item $(Join-Path $(Split-Path $(get-script) -Parent) "Compare-FormSha1.ps1")

$sfprop =  Get-item $(Join-Path $(Split-Path $(get-script) -Parent) "Set-FormProperty.ps1")

pushd $stsadmDir

[string] $results = "<Results>"

if ($debug -eq "true")
{
	$results += "<Debug>"
	$results += "XSN: $path2Xsn"
	$results += "</Debug>"
	$results += "<Debug>"
	$results += "MossUrl: $mossUrl"
	$results += "</Debug>"
	$results += "<Debug>"
	$results += "SHA1: $xsnSha1"
	$results += "</Debug>"
}

[string] $xsnFileName = $(Split-path $path2Xsn -leaf)

if ($verifyInfoPathForms -eq "true")
{
	$results += "<Result cmd=`"verifyformtemplate`" >"
	$results += .\stsadm.exe -o verifyformtemplate -filename $path2Xsn 2>&1
	$results += "</Result>"

	if ($lastexitcode -ne 0)
	{
		$results += "<Error>Could not verify form Template</Error>"
		return $($results + "</Results>")
	}
}

#all booleans are defaulted to true 

#set to true if form is not already load in region 
[bool] $isNewForm = $true

#set to true if form SHA1 vaule is different from one currently installed 
[bool] $isDifForm = $true

#set to true if script ran an operation
[bool] $didRun = $true

#form name 
[string] $formFullName = ""

foreach ($template in  $(.\stsadm.exe -o enumformtemplates))
{#check to see if the form is already loaded 

	if ($xsnFileName -eq $($template.split()[0]))
	{
		$isNewForm = $false
		
		#this boolean will represent weather the SHA1 is equal or not the 
		#currently installed form need to oass form name which is second part
		#enumformtemplates 
		
		#enumformtemplates results 
		#NewBusinessAdnd.xsn     urn:schemas-microsoft-com:office:infopath:NewBusinessAdnd:-myXSD-2008-08-17T06-04-10
		
		$formFullName = $($template.split()[1])
		
		$isDifForm = !$(& $csha1 $xsnSha1 $formFullName)
		
		#compare-sha1 returns true if the SHA1 match meaning we need to reverse it 
		#to say if the form is different 
		
		$results += "<Result cmd=`"CheckSHA1Value`" >"
		$results += "Is form different: $($isDifForm.ToString())"
		$results += "</Result>"
		
		break
	}
} 


if (!$isNewForm -and $isDifForm)
{
	$results += "<Result cmd=`"deactivateFormTemplate`" >"
	$results += .\stsadm.exe -o deactivateFormTemplate -filename $path2Xsn  -url $mossUrl 2>&1
	$results += "</Result>"

	if ($lastexitcode -ne 0)
	{
		$results += "<Error>Could not deactivate the form Template</Error>"
		return $($results + "</Results>")
	}
	else
	{
		sleep -seconds $sleepTime
	}
	
	if ($forceInfoPathDeploy -eq "true")
	{
		$results += "<Result cmd=`"removeFormTemplate`" >"
		$results += .\stsadm.exe -o RemoveFormTemplate -filename $path2Xsn 2>&1
		$results += "</Result>"

		if ($lastexitcode -ne 0)
		{
			$results += "<Error>Could not remove the form Template</Error>"
			return $($results + "</Results>")
		}
		else
		{
			sleep -seconds $sleepTime
		}
	}
}




if ($isNewForm -or ($forceInfoPathDeploy -eq "true" -and $isDifForm))
{
	$results += "<Result cmd=`"UploadFormTemplate`" >"
	$results += .\stsadm.exe -o UploadFormTemplate -filename $path2Xsn 2>&1
	$results += "</Result>"

	if ($lastexitcode -ne 0)
	{
		$results += "<Error>Could not Upload the form Template</Error>"
		return $($results + "</Results>")
	}
	else
	{
		sleep -seconds $sleepTime
	}
}
elseif($isDifForm)
{
	$results += "<Result cmd=`"UpgradeFormTemplate`" >"
	$results += .\stsadm.exe -o UpgradeFormTemplate -filename $path2Xsn -upgradetype Gradual 2>&1
	$results += "</Result>"

	if ($lastexitcode -ne 0)
	{
		$results += "<Error>Could not Upgrade the form Template</Error>"
		return $($results + "</Results>")
	}
	
}
else
{
	$didRun = $false
	
	$results += "<Result cmd=`"CheckFormSHA1`" >"
	$results += "The form SHA1 `($xsnSha1`) values are equal therefore no need to deploy"
	$results += "</Result>"
}

if ($didRun)
{
	$results += "<Result cmd=`"execadmsvcjobs`" >"
	$results += .\stsadm.exe -o execadmsvcjobs
	$results += "</Result>"

	if ($lastexitcode -ne 0)
	{
		$results += "<Error>Error when running execadmsvcjobs</Error>"
		return $($results + "</Results>")
	}
	else
	{
		sleep -seconds $sleepTime
	}

	$results += "<Result cmd=`"ActivateFormTemplate`" >"
	$results += .\stsadm.exe -o ActivateFormTemplate -filename $path2Xsn -url $mossUrl 2>&1
	$results += "</Result>"

	if ($lastexitcode -ne 0)
	{
		$results += "<Error>Could not Activate Form Template $path2Xsn</Error>"
		return $($results + "</Results>")
	}
	else
	{
		sleep -seconds $sleepTime
	}
	
	$results += "<Result cmd=`"SetFormPropertySHA1`" >"
	$results += & $sfprop "SHA1" $xsnSHA1 $formFullName
	$results += "</Result>"
}

popd 

return $($results + "</Results>")