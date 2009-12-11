#Upload-Files2Lib.ps1
#this process script will take collection of FileInfo objects and upload them 
#to a WSS/MOSS Library (I.E., sites Data Connection, Document, etc).
#Elements that exists in the library will be upgraded while new elements will be added
#
#Parameters:
#0: The full URL to the Data Connection Lib
#1: The relitive path to the site i.e. /sites/Agent or /sites/Employer 

param([string] $docliburl= $(throw 'The url to the library is required'),
	     [string]  $relweburl= $(throw 'The relitive web url is required'))
	     
   
begin
{
	[System.Reflection.Assembly]::LoadWithPartialName(”Microsoft.SharePoint”) > $null
	$site=new-object Microsoft.SharePoint.SPSite($docliburl)
	$web=$site.openweb($relweburl)
	$folder=$web.getfolder($docliburl)
	$list=$web.lists[$folder.ContainingDocumentLibrary]
	
	[string] $log = "<Results name=`"UploadFiles2DocLib`" doclibUrl=`"$docliburl`" relwebUrl=`" $relweburl`">"
}

process
{

	## I expect FileInfo objects in the pipeline
	[byte[]] $bytes= [byte[]] $(get-content $_.fullName -encoding byte)
	
	$log += "<Result action=`"AddFile`" file=`"$($_.FullName)`">"
	$log += $folder.files.Add($_.Name, $bytes, $null, $true)
	$log += "</Result>"

}

end 
{
	$site.dispose()
	$web.dispose()
	return $($log + "<Results>")
}