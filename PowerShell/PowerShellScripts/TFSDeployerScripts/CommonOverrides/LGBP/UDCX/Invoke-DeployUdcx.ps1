param([string] $path2UdcxDir = $(throw 'The full Unc path to UDCX directory is required'),
	  [string] $dataConnectionLibUrl = $(throw 'The full URL Data Connection Library is required'),
	  [string] $relSiteUrl = $(throw 'The relitive URL to the website is required'),
	  [string] $webServiceUrl = $(throw 'tjhe server port name of new UDCX is required'),
	  [string] $endPoint = $("http://as73mossdev01:9001/StsadmService.asmx"))

$req = new-object -com "Microsoft.XMLHTTP"
$req.open("POST", $endPoint, $false)
$req.setRequestHeader("Content-Type", "text/xml; charset=utf-8")
$req.setRequestHeader("SOAPAction", "http://harleysvillegroup.com/StsadmServices/UploadUdcx")
 
$requestString  = '<?xml version="1.0" encoding="utf-8"?>'                                                                                                                                  
$requestString += '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
$requestString += '  <soap:Body>'
$requestString += '    <UploadUdcx xmlns="http://harleysvillegroup.com/StsadmServices">'                                                                                                                     
$requestString += '      <path2UdcxDir>' + $path2UdcxDir + '</path2UdcxDir>' 
$requestString += '      <dataConnectionLibUrl>' + $dataConnectionLibUrl + '</dataConnectionLibUrl>' 
$requestString += '      <relSiteUrl>' + $relSiteUrl + '</relSiteUrl>' 
$requestString += '		 <webServiceUrl>' + $webServiceUrl + ' </webServiceUrl>' 
$requestString += '    </UploadUdcx>'                                                                                                                                                  
$requestString += '  </soap:Body>'                                                                                                                                                   
$requestString += '</soap:Envelope>'
 
$req.send($requestString)

$response = $req.responseText

if ($response.length -gt 1) 
{
	return $response
}
else
{
	return "<Results><Result cmd=`"WebserviceCall`">$response</Result><Error>Web service call failed</Error></Results>"
}

