SELECT server_name, database_name, 
	   name, 
	   description, 
	   backup_start_date, 
	   backup_finish_date
FROM msdb.dbo.backupset 
WHERE database_name = 'SRMTest' AND name LIKE '%27_2009%'
ORDER BY backup_start_date desc