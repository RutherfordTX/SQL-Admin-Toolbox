USE Master
GO


IF NOT EXISTS (SELECT 1 FROM sys.procedures WHERE name = N'usp_RunAdminQuery')
BEGIN;
    EXEC ('create proc usp_RunAdminQuery as select 1 as foo')
END;


-- exec admin.dbo.usp_RunAdminQuery @help = 1
-- exec admin.dbo.usp_RunAdminQuery @list = 1
-- exec admin.dbo.usp_RunAdminQuery @name = 'TransactionLogInfo'
-- exec admin.dbo.usp_RunAdminQuery @name = 'TempDBFileUsage', @print=1
-- SELECT *, LEN(code) FROM dbo.AdminQueries

ALTER PROCEDURE usp_RunAdminQuery
		@name VARCHAR(50) = NULL,
        @list int = 0,
		@print INT = 0,
		@help INT = 0
AS
/*==============================================================================
    File:		usp_RunAdminQuery
    Author:		John Rutherford
    Created:	2016-11-10
    Purpose:	This stored proc will run a prewritted query stored in the AdminQueries table on the local server.
				This is used to store commonly used queries
     
    Inputs:    @name - Query name    
    Outputs:   
    NOTES:  
    TODO:      
================================================================================
  Rev History:
  Date          Author              Description
================================================================================
2016-11-10		Rutherford			Initial Creation
2016-11-11		Rutherford			Added parameter to print the code vs execute
================================================================================
*/

-- Check for help
IF (@help = 1)
BEGIN
	PRINT 'This stored proc will run prewritten admin queries stored in the table admin.dbo.AdminQueries'
	PRINT 'To list all available queries with a description:'
	PRINT '     exec dbo.usp_RunAdminQuery @list = 1'
	PRINT 'To run one of the queries:'
	PRINT '     exec dbo.usp_RunAdminQuery @name = ''DatafileInfo'''
	PRINT 'To print the text of the script:'
	PRINT '     exec dbo.usp_RunAdminQuery @name = ''DatafileInfo'', @print=1'
	RETURN
END

-- Check to see if we are listing
IF (@list = 1)
BEGIN
	SELECT name, description
	FROM dbo.adminqueries
	RETURN
End

-- If we aren't listing but forgot to use @name then stop
IF (@name IS NULL)
BEGIN
	SELECT 'You must use the @name parameter. Run the proc with @list=1 to see all the options' AS ErrMessage
	RETURN
END

-- Variables are awesome
DECLARE @sqltext VARCHAR(5000)

-- Get the code from the table
SELECT @sqltext = code
FROM dbo.adminqueries
WHERE name = @name

IF (@print = 1)
BEGIN
	PRINT @sqltext
	RETURN
END


EXEC(@sqltext)
