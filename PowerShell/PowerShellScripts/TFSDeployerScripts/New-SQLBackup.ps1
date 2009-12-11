##New-TSQLBackup
#Ths script will return the TSQL code to get a copy only 
#backup of a database 

param([string] $path2bk = $(Throw 'The full UNC path to the .bak file is required'), 
	  [string] $dbName = $(throw 'Database name is required'),
	  [string] $desc = $("HPP Automated backup"))

###MAIN###

"EXECUTE master..sqlbackup N`'-SQL `"BACKUP DATABASE [$dbName] TO DISK = [$path2Bk] WITH COMPRESSION = 2, ERASEFILES = 1h, COPY_ONLY, DESCRIPTION = [$desc]`"'"