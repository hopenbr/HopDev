#remove-TFSGlobalListEntries
##This script will take a list of string values to remove them from a
#TFS GlobalList 

param([string] $glName = $(throw 'The Global List name is required'),
      [switch] $silent)

begin
{
	function get-script
	{
	if($myInvocation.ScriptName) { $myInvocation.ScriptName }
	else { $myInvocation.MyCommand.Definition }
	}
	
	[int] $count = 0
	
	pushd $(Split-Path (get-script) -Parent) 
	
	$tfs = .\Get-TFS.ps1 
	
	popd
	
	#the get entire global list from the server
	[xml] $gl = $tfs.wit.ExportGlobalLists()

	#separate out the specific list needed to be cleaned up
	[System.Xml.XmlElement] $list = $gl.SelectSingleNode("//GLOBALLIST[@name='$glName']")
	
	#ensure the list exists
	if ($list -eq $null)
	{
		throw "Error: Global list not found, List name $glName was not found"
	}
	elseif (-not $silent)
	{
		Write-Host "Global List $glName has been loaded"
	}
	
}

process
{
	#now process through the list of values that need to be removed 
	#from the list.  
	
	[System.Xml.XmlNode] $node = $list.SelectSingleNode("LISTITEM[@value='$_']")
	 
	 #ensure the list item exists
	if($node -ne $null)
	{
		#Remove the list item from the list
		
		$list.RemoveChild($node) | Out-Null
		$count++
		
		if (-not $silent)
		{
			Write-Host "List item: $_ has been removed"
		}
	}
	elseif(-not $silent)
	{
		Write-Warning "List Item: $_ was not found"
	}
}

end
{
	if($count -gt 0)
	{
		#import the globallist back
		#here were are ONLY IMPORTING the Global List we changed 
		#no other list will be imported
		#this is the reason we need to wrap the xml with the correct 
		#XML headers 
		
		$tfs.WIT.ImportGlobalLists("<?xml version=`"1.0`" encoding=`"utf-8`"?><gl:GLOBALLISTS xmlns:gl=`"http://schemas.microsoft.com/VisualStudio/2005/workitemtracking/globallists`"><GLOBALLIST name=`"$glName`">" + $list.get_InnerXml() + "</GLOBALLIST></gl:GLOBALLISTS>");
		
		if (-not $silent)
		{
			write-host "Global list $glName has been updated"
		}
		
	}
	elseif(-not $silent)
	{
		Write-Warning "No List items were found"
	}
	
}