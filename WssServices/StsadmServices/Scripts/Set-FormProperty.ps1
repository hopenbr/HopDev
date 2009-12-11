#Set-FormProperty
#this Script will set a form template property 

param([string] $pName = $(throw 'The Property name is required'),
      [string] $pValue = $(throw 'The Property value is required'),
      [string] $formName = $(throw 'The full form URN name is required')) 

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

###MAIN###

[bool] $successful = $false

$form = & $(Join-Path (Split-path $(get-Script) -Parent) "Get-InfoPathForm.ps1") $formName

if ($form)
{
	if ($form.properties.ContainsKey($pName))
	{
		$form.properties[$pName] = $pValue 
	}
	else
	{
		$form.properties.Add($pName, $pValue)
	}
	
	$successful = $true
	
	$form.Update()
}

return $successful