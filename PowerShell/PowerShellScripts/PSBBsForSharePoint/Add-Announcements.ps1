function global:Add-Announcements($url,$title){ 

$destWeb = get-SPweb -url $url 

$template = $destWeb.ListTemplates["Announcements"] 

$destWeb.Lists.Add($title+" News","News and announcements.",$template) 

Dispose-SPWeb($destWeb) 

} 

