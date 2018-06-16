use Master
GO

-- Only add if it doesn't exist
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'AdminQueries')
BEGIN 
	-- Build the table
	CREATE TABLE AdminQueries (
		name VARCHAR(50),
		description VARCHAR(200),
		code VARCHAR(5000)
	)
	CREATE UNIQUE CLUSTERED INDEX [CI_AdminQueries_Name] ON [dbo].[AdminQueries]
	(
		[name] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
END

GO







