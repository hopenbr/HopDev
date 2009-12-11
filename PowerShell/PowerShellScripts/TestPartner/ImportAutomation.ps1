#  Automate the Import Assets  Process  for Renewal Conversion
# 

#param([string]$dbi_num = $(throw 'Exception: Enter the DBI number ') )

#trap 
#{
#	 "An unexpected error has occur. please contact SRM"
#	 break
#}

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

pushd $(split-path (get-script) -parent)

$DebugPreference = "Continue"

$usrnam = "srm"

$usrdmn = $env:USERDOMAIN

Write-debug "Username who deploy the build is :$usrnam"

    
$tfs = ..\Get-Tfs.ps1


#Initialize the DSN name .

[string]$Tgtdsn_name=" "


#Manuscript will be copied from the Work item in TFS to temporary location 


$work_item= $tfs.wit.GetWorkItem($dbi_num)

if (!$work_item)
{
	return "Error: Could not retieve workitem"
}

#DSN name will be retrived from the DBI .

if ($work_item.Type.Name -ne "Deployment Backlog Item")
{
	return "Error: WorkItem Number $dbi_num not a Deployment Backlog Item"
}

if (-not ($work_item.AttachedFileCount -gt 0))
{
	return "Error: WorkItem Number $dbi_num has no attachments, Test partner XML migration file(s) need to be attached"
}

if (-not ($work_item.State -match "Approve"))
{
	return "Error: WorkItem Number $dbi_num not in Approved state"
}

$envt_value=$work_item.Fields["New Test Environment"].value


Write-debug "Target Environment value : $envt_value "


Switch($envt_value)
{
#TODO: convert to config XML 
 TST1    {
         $Tgtdsn_name = "Renewal_ConversionScripts_TST01"
            break
         }   

 End2End 
         {
	$Tgtdsn_name = "Renewal_ConversionScripts_E2E" 
           break 
         } 

 Production
         {
           $Tgtdsn_name = "Renewal_ConversionScripts_PRD"
           break  
         }  
 default {
          return "Error: DSN name is missing"  
         }  

}


Write-debug "Target DSN name :$Tgtdsn_name "
 
# Create object for Web-Client .

$web_client= New-Object System.net.webclient

$web_client.UseDefaultCredentials = $true


#Counter variable tell hpw many scripts are attached in the DBI 

$counter = $work_item.Attachments.Count

Write-debug " File attached with DBI : $counter "
[string] $results = ""

for($i= 0 ; $i -lt $counter ; $i++)
{
	$xml_path = " " 
     
	$file_name = $work_item.Attachments[$i].uri.AbsoluteUri 

	$file_path = $work_item.Attachments[$i].Name

	$xml_path="E:\\temp\$file_path"
	
	if (Test-Path $xml_path)
	{
		Remove-Item $xml_path -Force | Out-Null
	}
  
	$web_client.DownloadFile($file_name, $xml_path)
  
	Write-debug "Downloaded the  file  $file_path  Successfully "   
  
  # IMPORT OPERATION

    $res_file = "TPimport_Results_" + $dbi_num + "_" + $file_path + ".txt"

    $output = “E:\Temp\$res_file” 

	push-location 'E:\Program Files\Compuware\TestPartner\'


	$results += .\TPImport.exe -u $usrnam -p $usrnam -d $Tgtdsn_name -mt f -mn $xml_path  -av  -parc  a   -sarc  p   -rr   $output  -ex 2>&1
    
     if ($results -match "ERROR:") 
     {
		return "ERROR: An error was encounter `n****`n $results"
     }                                                    
	
	pop-location

    Write-debug "File Imported successfully using Test partner"

    #Result file of the import operation is saved .

    $atmt = New-Object Microsoft.TeamFoundation.WorkItemTracking.Client.Attachment( $output ,"Result file ")

    $work_item.Attachments.add($atmt)
    
    write-debug "Result file $res_file is attached to DBI "  

}

# DBI :Work item is saved and messages is updated in the history 


$work_item.State = "Deployed"


$Change_date = $work_item.ChangedDate


$msg = "Script was moved to $envt_value Environment at $change_date  Deployement was Kicked Off by $usrdmn \ $env:USERNAME " 


$work_item.History = $msg 
 

$work_item.save()


write-debug "Work-item Saved Successfully "

##Clean up 

Remove-Item -Path $xml_path -Force
Remove-Item -Path $output -Force

return $results














