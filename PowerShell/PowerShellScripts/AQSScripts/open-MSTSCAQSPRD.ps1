param ([string] $rdpDir = $("C:\Documents and Settings\bhopenw\My Documents\MSTSC\AQS\PRD\*.rdp"))

foreach ($rdp in $(ls $rdpDir))
{
	invoke-item $rdp 
}