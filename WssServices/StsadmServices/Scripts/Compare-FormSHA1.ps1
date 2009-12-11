#compare-FormSHA1
#this Script will compare the passed in SHA1 hash key to the loaded 
#forms SHA1 property 
#it will return a boolean 
#true if SHA1 vaules match 

param([string] $sha1 = $(throw 'A SHA1 string is required'),
      [string] $formName = $(throw 'The full form URN name is required')) 

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

###MAIN###

#set return value 
[bool] $areEqual = $false

$form = & $(Join-Path (Split-path $(get-Script) -Parent) "Get-InfoPathForm.ps1") $formName

if ($form -and $form.properties.ContainsKey("SHA1"))
{
	if ($form.properties.SHA1 -eq $sha1)
	{
		$areEqual = $true
	}
}

return $areEqual