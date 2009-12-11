##SQL Script and Replace 
#this script will search all files in the collection and
#use the SearchandReplace.xml to replace all values found
#

param([hashtable] $searches = $(throw 'Hashtable of Searches (Key is regex search Value is replace string) is required'))

begin
{
}

process
{
	#I expect the System.IO.FileInfo object
	
	#ensure not read-only
	$_.Attributes = 'Archive'
	
	$text = Get-Content $_.FullName
	
	Foreach ($key in $searches.keys)
	{
		$text = $text -replace $key, $searches[$key]
	}
	
	Set-Content -Value $text -Path $_.FullName -Force
}

end
{
}