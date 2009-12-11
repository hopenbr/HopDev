param([string] $path2Xsn = $(throw 'The full Unc path to XSN is required'),
	  [string] $endPoint = $("http://as73mosstst01:9001/StsadmService.asmx"),
	  [string] $mossUrl = $("http://as73mosstst01:24921"),
	  [string] $sha1 = $(''))

$req = new-object -com "Microsoft.XMLHTTP"
$req.open("POST", $endPoint, $false)
$req.setRequestHeader("Content-Type", "text/xml; charset=utf-8")
$req.setRequestHeader("SOAPAction", "http://harleysvillegroup.com/StsadmServices/AddInfoPathXsn")
 
$requestString  = '<?xml version="1.0" encoding="utf-8"?>'                                                                                                                                  
$requestString += '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
$requestString += '  <soap:Body>'
$requestString += '    <AddInfoPathXsn xmlns="http://harleysvillegroup.com/StsadmServices">'                                                                                                                     
$requestString += '      <path2Xsn>' + $path2Xsn + '</path2Xsn>' 
$requestString += '      <mossUrl>' + $mossUrl + '</mossUrl>' 
$requestString += '      <xsnSha1>' + $sha1 + '</xsnSha1>' 
$requestString += '    </AddInfoPathXsn>'                                                                                                                                                  
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
