if ((Read-Host -Prompt "Are you sure you want to run IISRESET on ALL AQS WS [Y\N]") -eq "y")
{
	
	iisreset WS73AQSPRD01
	iisreset WS73AQSPRD02
	iisreset WS73AQSPRD03
	iisreset WS73AQSPRD04
	iisreset WS73AQSPRD05
	iisreset WS73AQSPRD06
	iisreset WS73AQSPRD07
	iisreset WS73AQSPRD08

}