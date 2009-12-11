#Post-WebRequest will post a web request to the passed in URL using the 
#request file and it returns the request response as a string  

param([string] $url = $(throw 'The URL of the webpage is required'),
      [string] $Path2ReqFile = $(throw 'The Full UNC Path to the request file is required'))

#"http://clportaldev/UploadGateway.aspx"
#c:\q1.xml

$req = [System.Net.WebRequest]::Create($url)
$req.Method = "POST"
$req.ContentType = "text/xml"
[System.IO.StreamWriter]$writer = new-object System.IO.StreamWriter -ArgumentList $req.GetRequestStream()
[string] $uploadStr = $(gc $path2ReqFile -Encoding String)
$writer.WriteLine($uploadStr)
$writer.close()
$rsp = $req.getresponse()
[System.IO.StreamReader]$sr = New-Object System.IO.StreamReader -argumentList $rsp.GetResponseStream()
[string]$results = $sr.ReadToEnd();
return $results