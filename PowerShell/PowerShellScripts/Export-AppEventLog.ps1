#this simple script will take to got app Event Log and get the 
#latest events and export them to a HTML file 

param ([string] $exportFile = $('C:\temp\AppEventLogs.html'),
	   [int] $EventCount = $(50))
	   
Get-EventLog application -new $EventCount | 
	select EventID,EntryType,TimeGenerated,Source,Message | 
		convertto-html -body $("$b<br><h3>App Event Log ($env:Computername) as of $(Get-date)</h3><br>Latest $eventCount Events <br><hr><br>") | 
			out-file $exportFile 
		

return $(Get-Item -Path $exportFile)