#get-LGBPStg01Backup 
#this script will go out and get the 4:30 daily back up of the LGBP Database 
#on PRE01 and save it off in a temp area 
#once that is done we'll call the dev Importer to added it to TFVC 

#this is a very quick and dirty script that I just wanted to get done
#I know there is no flexibility 


$date = $(Get-Date).ToString("yyyyMMdd") + "16"


$bak = "\\us73media1\GBP_DS73SQLPRE01\GroupBenefitsPlatform_backup_" + $date + "*.bak"

if (Test-path $bak)
{

	$bak = get-item $bak

	Copy-item -path $bak -dest $("C:\Temp\LGBP\BAckUp\PRe01\" + $($bak.Name.Split("_")[0]) + ".bak")
}
else
{
	throw "Error: could not find back up at $bak"

}

$devImporter = Get-item "E:\TFS\HICPowerPlatform\ImportScripts\DevImporter\DevImporter.ps1"
& $devImporter 'E:\TFS\HICPowerPlatform\ImportScripts\DevImporter\Configs\LGBP\Config_SqlBak.xml' | out-null

 