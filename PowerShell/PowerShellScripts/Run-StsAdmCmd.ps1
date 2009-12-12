param([string] $cmd = $(throw 'The stsadm cmd is required'),
	  [string] $endPoint = $(throw 'Endpoint Url is required'))

$req = new-object -com "Microsoft.XMLHTTP"
$req.open("POST", $endPoint, $false)
$req.setRequestHeader("Content-Type", "text/xml; charset=utf-8")
$req.setRequestHeader("SOAPAction", "http://harleysvillegroup.com/StsadmServices/RunStsadmCmd")
 
$requestString  = '<?xml version="1.0" encoding="utf-8"?>'                                                                                                                                  
$requestString += '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
$requestString += '  <soap:Body>'
$requestString += '    <RunStsadmCmd xmlns="http://harleysvillegroup.com/StsadmServices">'                                                                                                                     
$requestString += '      <Cmd>' + $cmd + '</Cmd>' 
$requestString += '    </RunStsadmCmd>'                                                                                                                                                  
$requestString += '  </soap:Body>'                                                                                                                                                   
$requestString += '</soap:Envelope>'                                                                                                                                                         
$requestString += '  </soap:Body>'
$requestString += '</soap:Envelope>'
 
$req.send($requestString)
$response = $req.responseText
 
return $response