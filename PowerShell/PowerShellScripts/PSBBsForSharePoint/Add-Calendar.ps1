function global:Add-Calendar($url,$title){ 

    $destWeb = get-SPweb -url $url 

    $caltemplate = $destWeb.ListTemplates["Calendar"]     

    $listtitle = $title+" Events" 

    $destWeb.Lists.Add($listtitle,"Departmental calendar of events.",$caltemplate) 

    Dispose-SPWeb($destWeb) 

} 

