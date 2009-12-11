param([string] $path2wsp = $(throw 'The full Unc path to wsp is required'),
	  [string] $siteUrl = $(throw 'The full URL to top level of site collection is required'),
	  [string] $endPoint = $("http://as73mossdev01:9001/StsadmService.asmx"))

$req = new-object -com "Microsoft.XMLHTTP"
$req.open("POST", $endPoint, $false)
$req.setRequestHeader("Content-Type", "text/xml; charset=utf-8")
$req.setRequestHeader("SOAPAction", "http://harleysvillegroup.com/StsadmServices/AddSolutionWSP2SiteCollection")
 
$requestString  = '<?xml version="1.0" encoding="utf-8"?>'                                                                                                                                  
$requestString += '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
$requestString += '  <soap:Body>'
$requestString += '    <AddSolutionWSP2SiteCollection xmlns="http://harleysvillegroup.com/StsadmServices">'                                                                                                                     
$requestString += '      <Path2Wsp>' + $path2wsp + '</Path2Wsp>'    
$requestString += '      <SiteUrl>' + $siteUrl + '</SiteUrl>'  
$requestString += '    </AddSolutionWSP2SiteCollection>'                                                                                                                                                  
$requestString += '  </soap:Body>'                                                                                                                                                   
$requestString += '</soap:Envelope>'                                                                                                                                                         
$requestString += '  </soap:Body>'
$requestString += '</soap:Envelope>'
 
$req.send($requestString)
$response = $req.responseText
 
return $response
