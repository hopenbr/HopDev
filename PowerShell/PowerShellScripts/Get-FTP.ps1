param($localfile = $(throw 'Local download path is required'),
	  $remotefile = $(throw 'FTP path from root to file is required'),
	  $ftphost = $(throw 'FTP URL is requied' ),
	  $username= $(throw 'The username for FTP site is required'),
	  $password= $(thorw 'The password for FTP username is required'))



###MAIN###

$uri = $(Join-Path $ftphost $remotefile) 
$credentials=New-Object System.Net.NetworkCredential($username,$password)
$ftp=[System.Net.FtpWebRequest]::Create($URI)
$ftp.Credentials=$credentials
$ftp.UseBinary=1
$ftp.KeepAlive=0
$response=$ftp.GetResponse()
$responseStream = $response.GetResponseStream()
$file = New-Object IO.FileStream ($localfile,[IO.FileMode]::Create)[byte[]]
$buffer = New-Object byte[] 1024
$read = 0
do
{
	$read=$responseStream.Read($buffer,0,1024)
	$file.Write($buffer,0,$read)
}while ($read -ne 0)$file.close()

Return $(get-item $localfile)