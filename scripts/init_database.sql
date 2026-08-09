/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'Datawarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'Datawarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'Datawarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Datawarehouse')
BEGIN
    ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Datawarehouse;
END;
GO

-- Create the 'Datawarehouse' database
CREATE DATABASE Datawarehouse;
GO

-- Create schema, option 1
IF NOT EXISTS (
    SELECT 1 
    FROM INFORMATION_SCHEMA.SCHEMATA 
    WHERE SCHEMA_NAME in ('brz', 'sil','gld')
)
BEGIN
    EXEC('CREATE SCHEMA brz');
    EXEC('CREATE SCHEMA sil');
    EXEC('CREATE SCHEMA gld');
END;

-- Create schema, option 2
USE Datawarehouse;
GO

IF SCHEMA_ID('brz') IS NULL
    EXEC('CREATE SCHEMA brz');

IF SCHEMA_ID('sil') IS NULL
    EXEC('CREATE SCHEMA sil');

IF SCHEMA_ID('gld') IS NULL
    EXEC('CREATE SCHEMA gld');
