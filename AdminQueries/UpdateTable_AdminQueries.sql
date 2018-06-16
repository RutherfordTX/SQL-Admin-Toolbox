use Admin
GO


-- View the current contents
SELECT *
FROM dbo.AdminQueries
WHERE name = 'BackupSettings'


-- Create a row
INSERT INTO dbo.AdminQueries
        ( name, description, code )
VALUES  ( 'ClearBackupSettings', -- name - varchar(50)
          'Clears the in progress flags for Full, BAK and Diff backups', -- description - varchar(200)
          'UPDATE admin.dbo.tblBackupsDatabaseInfo
SET FullBackupInProgress = NULL,
BakBackupInProgress = NULL,
DiffBackupInProgress = NULL'
          )


-- Update a row
UPDATE dbo.adminqueries
SET code = 'SELECT DatabaseName,
	RecoveryModel,
	DBStatus,
	BakBackupNeeded,
	BakBackupFrequency,
	BakBackedUp,
	BakBackupInProgress,
	FullBackupNeeded,
	FullBackupFrequency,
	FullBackedUp,
	FullBackupInProgress,
	DiffBackupNeeded,
	DiffBackupFrequency,
	DiffBackedUp,
	DiffBackupInProgress,
	TLogBackupNeeded,
	TLogBackupFrequency,
	TLogBackedUp,
	TLogBackupInProgress
FROM dbo.tblBackupsDatabaseInfo
WHERE DBStatus = ''Online''
ORDER BY DatabaseName'
WHERE name = 'BackupSettings'


EXEC admin.dbo.usp_RunAdminQuery @name='BackupSettings'

EXEC dbaadmin.dbo.usp_UpdateAdminQueries

