#Invoke-SiteCollectionReinstall
#this script will prompt the user for which
#site collection he/she wants to reinstall 
#read the xml config and invoke 
#SiteRetractionCreation Script 

param([switch] $gui, #switch to run the Gui to get sites
	  [switch] $agent, #auto switch to reinstall agent site
	  [switch] $employer, #auto switch to reinstall employer site
	  [switch] $carrier) #auto switch to reinstall carrier site


function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

function wh ([string] $out)
{
	Write-Host -ForegroundColor DarkCyan $out
}

function get-Sites()
{
	if($agent -or $carrier -or $employer)
	{
	    #at least one of the auto switches were passed in therefore
		#all we need to do is see which ones were passed a return the site
		if ($agent)
		{
			"Agent"
		}
		
		if ($employer)
		{
			"Employer"
		}
		
		if ($carrier)
		{
			"Carrier"
		}
		
		return
	}
	else
	{
	#no auto switches therefore need to ask user what sites to reinstall
	
		if($gui)
		{
			return get-SitesGui
		}
		else
		{
			wh "Please select a site collection to reinstall"
			wh "To select mulitples you need to run the GUI" 
			wh ""
			$result = Read-Host -Prompt "[A] agent, [C] carrier, [E] employer, [L] all, [G] gui, or [X] exit"
			
			switch -regex ($result) {
				"A|a" {return "Agent"}
				"C|c" { return "Carrier"}
				"E|e" { return "Employer"}
				"L|l" { return ("Agent", "Carrier", "Employer")}
				"G|g" { return get-SitesGui}
				"X|x" { exit}
				default { return get-sites}
			}
		}
	}
}

function get-SitesGui()
{
	pushd $(Split-Path (get-script) -Parent)
	.\Get-SiteCollections.ps1
	popd
}


###MAIN###

[xml] $config = [xml] $(gc $((get-script) + ".config"))

[System.IO.FileInfo] $reinstall = gi $(Join-Path $(Split-Path (get-script) -Parent) "SiteRetractionAndCreation.ps1" )

foreach ($site in (get-sites))
{
	wh "Reinstalling $site"
	
	$siteInfo = $config.sites.selectSingleNode("site[@Name='$site']")
	
	& $reinstall $siteInfo.Name $siteInfo.WspName $siteInfo.Url $siteInfo.TemplateName
	
	wh "Reinstall of $site site complete"
}