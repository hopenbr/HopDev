##Import-ReleaseChanges.ps1 
#this script is intended to get changes to Releases when release has already
#been added to TFVC 

param($deployer = $(throw 'SRM TFS deployer object is required'),
      $serverPath = $(throw 'The TFVC server path is required'),
	  $localPath = $(throw 'The local path to new elements is required'))



function Get-ConfigXml ([string] $commonScripts, 
						[string] $tfsUrl, 
						[string] $email, 
						[string] $wsName, 
						[string] $baseDir, 
						[string] $comment, 
						[string] $local, 
						[string] $server, 
						[string] $subFolder)
{
"<?xml version=`"1.0`" encoding=`"utf-8`"?>
<Settings>
	<!--EventSource: The name of event raised to App Event log-->
	<EventSource>HIC.Deployer</EventSource>
	
	<!--CommonScriptsLocation: location of HICPowerPlatform locally on server -->
	<CommonScriptsLocation>$commonScripts</CommonScriptsLocation>
	
	<!--TFSUrl: Url to Team Foundation Server -->
	<TFSUrl>$tfsUrl</TFSUrl>
	
	<!--ErrorRecipecnt: Address(es) where exception message is sent; separate addresses with semi-colon -->
	<ErrorRecipient>$email</ErrorRecipient>
	
	<!--AddOrphans: True or False weather Orphaned files on Share should be added to TFVC -->
	<AddOrphans>true</AddOrphans>
	
	<!--Debug: Set to true to output all debug info to Event log-->
	<Debug>false</Debug>
	
	<SyncSwitches>--delete:n --overwrite:y --synctime:n --rename:n --notime --ignorewarnings</SyncSwitches>
	
	<!--Workspace: Particulars about the local workspace used for import to TFVC -->
	<Workspace>
		   <!--Name: The Name of the local TFVC workspace -->
		<Name>$wsName</Name>
		
		<!--BaseDir: The Base directory for the Workspace, for the importer to work all mappings must be 
			  under same parent directory pointing to diffect sub-directories-->
		<BaseDir>$baseDir</BaseDir>
		
	</Workspace>
	
	<!--CheckInComment: Comment used when checking -->
	<CheckInComment>$comment</CheckInComment>
	
	<!--Shares: The Mapping of the Shares to TFVC-->
	<Shares>
		   <!--Shares can have One to many share -->
		<Share>
			   <!--Target: Full UNC path to share. The share holds the truth, meaning if there is a 
						difference between TFVC and the Share, the share element will be imported into TFVC-->
			<Target>$local</Target>
			
			<!--TFVC: mapping for TFVC-->
			<Tfvc>
				  <!--ServerPath: Full path to server location on TFVC -->
				<ServerPath>$server</ServerPath>
				
				<!--SubFolder: Name of local sub-directory under Workspace BaseDir  -->
				<SubFolder>$subFolder</SubFolder>
			</Tfvc>
		</Share>
	</Shares>
</Settings>
"
}



###MAIN###

#Get-ConfigXml ([string] $commonScripts, 
#						[string] $tfsUrl, 
#						[string] $email, 
#						[string] $wsName, 
#						[string] $baseDir, 
#						[string] $comment, 
#						[string] $local, 
#						[string] $server, 
#						[string] $subFolder)


[string] $tempConfig = $(Join-Path $deployer.config.Deployment.TempLocation $($deployer.BuildData.BuildNumber + ".xml"))
[string] $workspace = $deployer.BuildData.BuildNumber + "_" + $(Get-Date).ToString("yyyyMMMdd")

Get-ConfigXml $deployer.Config.Deployment.CommonScriptsLocation $deployer.Config.Deployment.TFSServerUrl $deployer.EmailRecipient $workspace $(Split-Path $localPath -Parent) "Config Updates" $localPath $serverPath "Changes" | Out-File -FilePath $tempConfig
[bool] $success = .\ImportScripts\DevImporter\DevImporter.ps1 $tempConfig

#clean up 
Remove-Item -Path $tempConfig -force

$deployer.TFS.vcs.deleteworkspace($workspace, $env:username) | out-null

Remove-Item -Path (Join-Path $(Split-Path $localPath -Parent) "Changes") -force -recurse

return $success


