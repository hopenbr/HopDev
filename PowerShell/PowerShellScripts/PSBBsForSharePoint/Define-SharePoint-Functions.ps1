# Copied from http://sharepoint.microsoft.com/blogs/zach/Script%20Library/functions.ps1 on 23 July 2008 at 5:54pm CT.
# Copied by Michael Blumenthal with permission from the author, Zach Rosenfield.
# Zach's Blog: http://sharepoint.microsoft.com/blogs/zach
# Other PowerShell functions available from Zach at http://sharepoint.microsoft.com/blogs/zach/Script%20Library/Forms/AllItems.aspx
# This library is explained in two posts - look here: http://sharepoint.microsoft.com/blogs/zach/Lists/Posts/Post.aspx?ID=21
# Thank you, Zach!
## SharePoint DLL
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")

############################################
#  Get-SPFarm
#	  ::Returns local farm
############################################

function global:Get-SPFarm{
   return [Microsoft.SharePoint.Administration.SPFarm]::Local 
}

############################################
#  Get-SPWebApplication
#	  ::Returns web applications in the local farm.
############################################

function global:Get-SPWebApplication{
   Get-SPFarm |% {$_.Services} | where {'$_.TYPEName -eq "Windows SharePoint Services Web Application"'} |% {$_.WebApplications} |% {Write-Output $_}
}

############################################
#  Get-SPSite -url <url>
#	  ::Returns SPSite at the given URL
############################################

function global:Get-SPSite($url){
   return new-Object Microsoft.SharePoint.SPSite($url)
}

############################################
#  Get-SPWeb [-url <url> | -site <SPSite>]
############################################
function global:Get-SPWeb($url,$site)
{
    if($site -ne $null -and $url -ne $null){"Url OR Site can be given"; return}
	#if SPSite is not given, we have to get it...
	if($site -eq $null){
		$site = Get-SPSite($url);
	}

  #Output 1 or more sites...
  if($url -eq $null){
    for($i=0; $i -lt $s.AllWebs.Count;$i++){ 
	  Write-Output $s.AllWebs[$i]; ##Send through Pipeline
	  $s.Dispose();  ##ENFORCED DISPOSAL!!!
	}
  }else{
	Write-Output $site.OpenWeb()
  }
}

############################################
#  Dispose-SPWeb -web <SPWeb> -parent <bool>
############################################
function global:Dispose-SPWeb($web,$parent=$false){
  $site = $web.Site;
  $web.Dispose();
  if($parent){ $site.Dispose(); }
}

############################################
#  Dispose-SPSite -Site <SPSite>
############################################
function global:Dispose-SPSite([Microsoft.SharePoint.SPSite]$Site){
  PROCESS{
  	if($_){
	  $_.Dispose();
	}else{
	  $Site.Dispose();
	}
  }
}

############################################
#  Set-SPQuota -Site <SPSite> -MaxSize <bytes> -WarnSize <bytes> -NoRefresh
############################################
function global:Set-SPQuota([Microsoft.SharePoint.SPSite]$Site,[Long]$MaxSize=-1,[Long]$WarnSize=-1,[Switch]$NoRefresh=$false,[Switch]$PassThru){
	process{
		if($Site -eq $null){ $tSite = $_ }else{$tSite = $Site}
		#Refresh SPSite Object...
		if(!$NoRefresh){
			$tSite = new-Object Microsoft.SharePoint.SPSite($tSite.Url);
		}
		#Set Warning Size
		if($WarnSize -gt -1){
			$tSite.Quota.StorageWarningLevel = $WarnSize;
		}
		#Set Max Size
		if($MaxSize -gt -1){
			$tSite.Quota.StorageMaximumLevel = $MaxSize;
		}
		#PassThru
		if($PassThru){
			Write-Output $tSite;
		}
	}
}

############################################
#  Get-SPQuota -Site <SPSite>
############################################
function global:Get-SPQuota([Microsoft.SharePoint.SPSite]$Site){
	process{
		if($Site -eq $null){ Write-Output $_.Quota }
		else{ Write-Output $Site.Quota }
	}
}


