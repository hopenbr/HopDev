param ([string] $type = $(throw 'The site type is rrequired (Agent/Employer/Carrier)'), 
       [string] $wsp = $(throw 'The name of the wsp is required'), 
       [string] $url = $(throw 'The full url to the site is required'), 
       [string] $siteTemp = $(throw 'The site template name is required i.e. (AgentSiteDefinition)'),
	   [switch] $skipRetract,
	   [switch] $skipCreation)


function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

###MAIN###

$ErrorActionPreference = "Stop"

if ($HelperFunctions -ne 1)
{
	##helper functions are where alais are set up and function to do 
	#some of the heavy lifting that is not done via Stsadm 
	
	pushd $(split-path $(get-script) -parent)
	.\Wss.Helper.Functions.ps1
	popd
}

if (-not $skipRetract)
{
	[string] $path2UDCXlibBackups = $("C:\SPExports\$type" + $(Get-Date).ToString('yyyyMMdd'))
	
	[string] $path2LogFiles = $("C:\SPLogs\$type\" + $(Get-Date).ToString('yyyyMMdd'))
	
	wh "Backing up UDCX libraries" 
	
	ExportSiteUDCXLibraries $url $path2UDCXlibBackups
	
	wh "Retracting Sln: $wsp" 
	
	sa -o retractsolution -name $wsp -immediate -allcontenturls
	sa -o execadmsvcjobs
	
	wh "Deleting sln: $wsp"
	sa -o deletesolution -name $wsp
	
	wh "Deleting Site: $url"
	sa -o deletesite -url $url -deleteadaccounts false
	
	wh "Resetting IIS"
	
	iisreset -noforce
	
	
	Read-Host -Prompt "Please deploy the correct $type wsp package hit enter to continue once deployment is complete"

}

if (-not $skipCreation)
{
	wh "Creating site: $url based on $siteTemp" 
	
	sa -o createsite -url $url -owneremail bhopenw@harleysvillegroup.com -ownerlogin "CORP\BHOPENW" -secondarylogin "CORP\TFSBUILD" -sitetemplate $siteTemp -Title $type
	
	wh "Activating Features..." 
	
	sa -o activatefeature -name PremiumSite -url $url
	sa -o activatefeature -name PremiumWeb -url $url
	
	sa -o activatefeature -name BaseSite -url $url
	sa -o activatefeature -name BaseWeb -url $url
	
	sa -o activatefeature -name PublishingSite -url $url
	sa -o activatefeature -name PublishingWeb -url $url
	
	sa -o activatefeature -name SearchWebParts -url $url
	
	wh "Creating vistor group: $type"
	
	sa -o creategroup -url $url -name $type -ownerlogin "Corp\TFSBUILD" -type visitor -description "$type visitor"
	
	wh "Adding Members to $type Group" 
	
	##the 'useremail' parameter is a requirement thus 
	##the vaules are made up
	
	switch ($type) 
	{
		"Agent" 
		{
			sa -o adduser -url $url -userlogin "fbaroles:agent" -useremail "LgbpFbarolesAgent@harleysvilleGroup.com" -group $type -username "Agent"
		}
		"Employer" 
		{
			sa -o adduser -url $url -userlogin "fbaroles:employer" -useremail "LgbpFbarolesEmployer@harleysvilleGroup.com" -group $type -username "Employer"
		}
		"Carrier" 
		{
			sa -o adduser -url $url -userlogin "CORP\LifeGBPUsers" -useremail "LifeGBPUsers@harleysvilleGroup.com" -group $type -username "LifeGBPUsers"
			sa -o adduser -url $url -userlogin "CORP\LifeGBPtstUsers" -useremail "LifeGBPtstUsers@harleysvilleGroup.com" -group $type -username "LifeGBPtstUsers"
			sa -o adduser -url $url -userlogin " corp\lifegbpdevelopers" -useremail "LifeGBPDevelopers@harleysvilleGroup.com" -group $type -username "LifeGBPDevelopers"
			
	
			[string] $g = "CarrierOther"
			wh "Creating vistor group: $g"
			
			sa -o creategroup -url $url -name $g -ownerlogin "Corp\TFSBUILD" -type visitor -description "$type $g visitor"
			
			wh "Adding Members to $g Group" 
			sa -o adduser -url $url -userlogin "corp\lifegbptstotherusers" -useremail "LifeGBPtstotherusers@harleysvilleGroup.com" -group $g -username "LifeGBPtstotherusers"
			
			$g = "CarrierStaff"
			wh "Creating vistor group: $g"
	
			sa -o creategroup -url $url -name $g -ownerlogin "Corp\TFSBUILD" -type visitor -description "$type $g visitor"
			

			$g = "SuperUser"
			wh "Creating vistor group: $g"
	
			sa -o creategroup -url $url -name $g -ownerlogin "Corp\TFSBUILD" -type visitor -description "$type $g visitor"
			
			wh "Adding Members to $g Group" 
			
			sa -o adduser -url $url -userlogin "CORP\LifeGBPtstsuperUsers" -useremail "LifeGBPststsuperUsers@harleysvilleGroup.com" -group $g -username "LifeGBPtstsuperUsers"
			
			
			$g = "UserAdmin"
			wh "Creating vistor group: $g"
	
			sa -o creategroup -url $url -name $g -ownerlogin "Corp\TFSBUILD" -type visitor -description "$type $g visitor"
			
			wh "Adding Members to $g Group" 
			
			sa -o adduser -url $url -userlogin "corp\lifegbptstumsusers" -useremail "LifeGBPststsuperUsers@harleysvilleGroup.com" -group $g -username "LifeGBPtstumsusers"
			sa -o adduser -url $url -userlogin "corp\lifegbpdevelopers" -useremail "lifegbpdevelopers@harleysvilleGroup.com" -group $g -username "LifeGBPDevelopers"
	
		}
	}
	
	wh "Activating Base InfoPath forms"
	
	ActivateLGBPInfoPathForms $url
	
	if (-not $skipRetract)
	{
		wh "Restoring Sites UDCX libraries"
		
		ImportSiteUDCXLibraries $url $path2UDCXlibBackups $path2LogFiles
		
		wh "Housecleaning..."
	
		remove-item $path2UDCXlibBackups -recurse -force
	}
	
	wh "Site creation complete, opening site for checkout" 
	
	explorer $url

}


