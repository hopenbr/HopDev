##This script will create a Infomatica Label 
#Script is design to be called via TFS Event Services 
#The Event Service will set the following variables in the shell 
#before calling this scripts
#for local test un-comment below 

#param ([string] $region = $(throw 'The repository region is required, ie Rep_E2E'),
#[string] $labelType = $(throw 'The label type/project is required, ie APP_CLDR'),
#[string] $hostName = $(throw 'The host elt machine name is required'),
#[string] $requestedBy = $(throw 'The person requestiong the label is required')) 

function get-ScriptLocation()
{
	if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   	else { $myInvocation.MyCommand.Definition }
}

#get date stamp for Label 2008JUL25
$dateStamp = $(Get-Date).ToString("yyyyMMMd").ToUpper()

$baseLabel = $labelType + "_" + $dateStamp

#this is the encryption hash for CORP\TFSBUILD pwd for each server. 
 
$pwdHash = @{"Rep_DEV" = 'E$17"Ag5X3TS';
			 "Rep_TST1" = 'R1343RxFiDed';
			 "Rep_E2E" = 'S1354SyGjEfe'}

Set-Location $( split-path (get-ScriptLocation) -parent)
$location = $(pwd)

[string] $check4Label = (join-path $location.Path "Check4Labels.bat") 
[string] $outputPath = (Join-Path $location.Path "Check4Labels.txt")
[string] $catcher = "$check4Label * $baseLabel * $outputPath * $region * $hostName * $($pwdHash[$region] | out-string)"

$results = cmd /c $check4Label $baseLabel $outputPath $region $hostName $($pwdHash[$region] | out-string)

$catcher += $results

if (!($results -match "No Label ERROR"))
{
	[array] $labels = (GC $outputPath)
	
	[char] $labelLetter = "A"
	
	if ($labels.Count -gt 1)
	{
	
		foreach ($label in $labels)
		{
			$letter = $($label -replace "label $baseLabel", "").Trim()
			
			if ($letter.length -eq 1 -and $letter -as [char] -gt $labelLetter)
			{
				$labelLetter = $letter -as [char]
			}
			
		}
		
		
		$labelLetter = [char]([int]($labelLetter) + 1)
		
	
	}
	
	$baseLabel += $labelLetter -as [string]
	
	Remove-Item $outputPath -Force 
}

[string] $createLabel = (Join-Path $location.Path "CreateLabel.bat")

$results = cmd /c $createLabel $baseLabel $requestedBy $region $hostName $($pwdHash[$region] | out-string)

$catcher += $results

#$catcher

if ($results -match "createlabel completed successfully.")
{
	return $baseLabel	
}
else
{
	$catcher | out-file (Join-Path $location.Path "ERROR.txt")
	return $false
}
