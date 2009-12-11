####
#Label-ParentTFVCFolders.ps1 
#this script will label the parent folders of a build type 
#this way build mapping can be directly to solution folder 
#no need to keep up w/ cloaking 
#Afterlabel this script will be called to add the parents folder up
#to the Branches folder to label items collection 

param([string] $elements = $(throw 'comma separated list of string TFVC server paths pointing to folders is required'),
	  [string] $labelName = $(throw 'Label name is required'),
	  [string] $labelOwner = $(throw 'The user ID of label owner is required'),
	  [string] $recursive = $("none"),
	  [string] $tfsServerUrl = $("Http://as73tfs01:8080"))
	  
trap
{
	$host.SetShouldExit(2)
	return $false
}


function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

function get-RecursionType ($type)
{
	switch ($type)
	{
		"Full" 
		{
			return "Full"
		}
		
		"F" 
		{
			return "Full"
		}
		
		"OneLevel" 
		{
			return "OneLevel"
		}
		
		"One" 
		{
			return "OneLevel"
		}
		
		default 
		{
			return "none"
		}
	}
}
	  
	  
###MAIN###


pushd $(split-path (Get-script) -Parent)

[string] $recursion = get-RecursionType $recursive

$results = $elements.Split(",") | ..\Label-TFVCFolders.ps1 $labelName $labelOwner $recursion $tfsServerUrl

if ($results["LabelResults"])
{
	$host.SetShouldExit(0)
	return $true
}
else
{
	#none vaild server paths were given 
	$host.SetShouldExit(1)
	return $false
}
