##Upload-MossUdcx
#this script will upload the latest udcx files to a particular data connection library 
#the script auto uplad the udcx file to have to correct urls for web service endpoints 
#Assumes:
#  - The element DataSource\ConnectionInfo\WsdlUrl is present and populated with Url 
#  - The web services are hosted on the same server as the MOSS server
#  - All URLs are correct 
#		ex/ URL -> http://<serverName>:Port/server1.asmx 
#		Assumption -> everthing after server name and port is correct
#
#this script will return results xml 
#This script is designed to be run via the stsadmService web service app, to test locally you will
#need to uncomment the below parameters else wise these all parameters are set as global varibles 
#by the parent web method

#param([string] $path2UdcxDir = $("\\w73hic403310\c$\TFSWorkspaces\Legacy\Branches\DEVELOPMENT\LossControl\InfoPath\UDCX"),
#	   [string] $dataConnectionLibUrl = $("http://as73mossdev01:21603/sites/Srm/Test%20Udcx"),
#	   [string] $relSiteUrl = $("/Sites/Srm"),
#      [string] $webServiceHost = $("As73mossdev01:9001"),
#	   [string] $path2tempDir = $("C:\Temp"),
#	   [string] $debug = $("false"))


function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

pushd $(split-path (Get-script) -Parent)

[string] $results = "<Results>"

if ($debug -eq "true")
{
	$results += "<Debug>"
	$results += "path2UdcxDir: $path2UdcxDir"
	$results += "</Debug>"
	$results += "<Debug>"
	$results += "dataConnectionLibUrl: $dataConnectionLibUrl"
	$results += "</Debug>"
	$results += "<Debug>"
	$results += "relSiteUrl: $relSiteUrl"
	$results += "</Debug>"
	$results += "<Debug>"
	$results += "webServiceHost: $webServiceHost"
	$results += "</Debug>"
	$results += "<Debug>"
	$results += "path2tempDir: $path2tempDir"
	$results += "</Debug>"
}

[System.Io.FileInfo] $udcxFile = $null

$results += "<Result action=`"GetTempDir`" >"

[string] $timeStamp = $(Get-Date).ToString("yyyyMMddhhmmss")

$tempDir = Join-Path $path2tempDir $timeStamp

New-Item -ItemType Directory -Path $path2TempDir -Name $timeStamp | Out-Null

$results += "$tempDir</Result>"

$results += "<Result action=`"UpdateWebserviceUrl`" >"

[regex] $rx = [regex] "http(|s)\://(\w+\:\d+?)/"

foreach ($uf in (ls $path2UdcxDir))
{
	[xml] $udcx = [xml] (gc $uf.FullName)
	[string] $replaceWith = "$($webServiceHost.trim())"
	[string] $match = $($rx.match($udcx.DataSource.ConnectionInfo.WsdlUrl)).Groups[2].value
	[string] $replaceUrl = ""
	
	if (!($replaceUrl -eq $match) -and $match.length -gt 0)
	{
		$replaceUrl = $match
	}
	elseif ($match.length -eq 0)
	{
		$replaceUrl = $($rx.match($udcx.DataSource.ConnectionInfo.UpdateCommand.FolderName.'#Text')).Groups[2].value
	}
	
	if ($replaceUrl.length -eq 0)
	{
		[regex] $rxIP = [regex] "http(|s)\://(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\:\d+?)/"
		
		$match = $($rxIP.match($udcx.DataSource.ConnectionInfo.WsdlUrl)).Groups[2].value
		
		if ($match.length -eq 0)
		{
			$replaceUrl = $($rxIP.match($udcx.DataSource.ConnectionInfo.UpdateCommand.FolderName.'#Text')).Groups[2].value
			
			if ($replaceUrl.length -eq 0)
			{ 
				$results += "<Error>No replacement Url string was retrieved in $($uf.Name) by regex</Error></Result></Results>"
				break
			}
		}
		else
		{
			
			$replaceUrl = $match
		}
	}
	
	if ($replaceWith -ne $replaceUrl)
	{
		$(gc $uf.FullName) -replace "$replaceUrl", "$replaceWith" | Set-Content -Path $(Join-Path $tempDir $uf.Name)
		$results += "<Item>$($uf.Name) updated: $replaceUrl replaced by $replaceWith</Item>"
	}
	else
	{
		copy-item -path $uf.FullName -dest $tempDir -force 
	}
}

if ($results -match "<Error>")
{
	return $results
}
$results += "</Result>"

$results += "<Result action=`"GetDataConnLib`" >"

#we are ensure that Data Conn lib exists if not will create it 
#first we need to Data Con lib name which is the last part of the Url 
$dataConnectionLibUrl -match "/(\w+$)" | Out-Null

[string] $dclName = $matches[1]

#now call get script will either return the existing Data Con Lib SPList object 
#or create a new Data Conn lib 

$list = .\Get-DataConnectionLib.ps1 $dataConnectionLibUrl $dclName $true

$results += "</Result>"

$results += "<Result action=`"UploadFiletoDataConnLib`" >"
#call process to upload files 
$results += ls $tempDir | .\Upload-Files2Lib.ps1 $dataConnectionLibUrl $relSiteUrl

$results += "Upload Complete</Result>"

Remove-Item -Path $tempDir -Recurse -Force 

$results += "<Result action=`"CleanUp`" >Delete $tempDir </Result>"

popd

return $($results + "</Results>")