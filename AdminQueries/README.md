# AdminQueries
Process to save and execute scripts on a SQL Server

The purpose of this project was to build a way to run admin queries (backup status, cpu info, etc) that are frequently run.
I got tired of having to find the scripts when I needed them.
This way they are stored on a server and run directly from there.

The process is:

Create the table and populate it with Queries that you run frequently
Then you can execute the stored proc to run the queries

By default all objects are created in Master.

The folder contains three files
1. CreateTable_AdminQueries.sql - Run this to creat the table 
2. usp_RunAdminQuery.sql - This will create the stored proc.
3. UpdateTable_AdminQueries.sql - sample queries showing how to insert and update into the table.
