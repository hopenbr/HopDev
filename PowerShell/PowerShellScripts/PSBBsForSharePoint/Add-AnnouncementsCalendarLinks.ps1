function global:Add-AnnouncementsCalendarLinks($url,$title){ 

    Add-Announcements -url $url -title $title 

    Add-Calendar -url $url -title $title 

    Add-LinksList($url)     

} 

