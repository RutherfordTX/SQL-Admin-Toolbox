USE Admin
GO

-- View the current contents
SELECT *
FROM dbo.AdminQueries
WHERE name = 'BackupsLastSevenDays'


-- Create a row
INSERT INTO dbo.AdminQueries
        ( name, description, code )
VALUES  ( 'BackupsLastSevenDays', -- name - varchar(50)
          'Lists all Backups on a server for the previous 7 days', -- description - varchar(200)
          'SELECT 
   CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server,
   bs.user_name,
   bs.database_name,
   bs.backup_start_date, 
   bs.backup_finish_date,
   bs.expiration_date,
   CASE bs.type 
       WHEN ''D'' THEN ''DB Full''
       WHEN ''L'' THEN ''Log''
       WHEN ''I'' THEN ''Differential''
       ELSE bs.type
   END AS backup_type,
   bs.is_snapshot,
   bs.is_copy_only,
   bs.backup_size, 
   bmf.logical_device_name, 
   bmf.physical_device_name,  
   bs.name AS backupset_name,
 --  bs.description,
   bs.first_lsn,
   bs.last_lsn,
   bs.database_backup_lsn,
   bs.checkpoint_lsn
FROM   msdb.dbo.backupmediafamily AS bmf
INNER JOIN msdb.dbo.backupset AS bs
    ON bmf.media_set_id = bs.media_set_id
WHERE  (CONVERT(datetime, bs.backup_start_date, 102) >= GETDATE() - 7)
ORDER BY 
   bs.database_name,
   bs.backup_finish_date DESC'
          )


-- Update a row
UPDATE dbo.adminqueries
SET code = 'SELECT 
   CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server,
   bs.user_name,
   bs.database_name,
   bs.backup_start_date, 
   bs.backup_finish_date,
   bs.expiration_date,
   CASE bs.type 
       WHEN ''D'' THEN ''DB Full''
       WHEN ''L'' THEN ''Log''
       WHEN ''I'' THEN ''Differential''
       ELSE bs.type
   END AS backup_type,
   bs.is_snapshot,
   bs.is_copy_only,
   bs.backup_size, 
   bmf.logical_device_name, 
   bmf.physical_device_name,  
   bs.name AS backupset_name,
 --  bs.description,
   bs.first_lsn,
   bs.last_lsn,
   bs.database_backup_lsn,
   bs.checkpoint_lsn
FROM   msdb.dbo.backupmediafamily AS bmf
INNER JOIN msdb.dbo.backupset AS bs
    ON bmf.media_set_id = bs.media_set_id
WHERE  (CONVERT(datetime, bs.backup_start_date, 102) >= GETDATE() - 7)
ORDER BY 
   bs.database_name,
   bs.backup_finish_date DESC'
WHERE name = 'BackupsLastSevenDays'



