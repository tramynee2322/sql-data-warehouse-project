/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC brz.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE brz.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; /*Track ETL Duration: helps to identify bottlenecks, optimize performance, monitor trends, detect issues*/

    BEGIN TRY /* Add TRY ... CATCH: Ensures error handling, data integrity, and issue logging for easier debugging
                 TRY... CATCH: SQL runs the TRY block, and if it fails, it runs the CATCH block to handle the error   */
        PRINT 'LOADING BRONZE LAYER';
        PRINT '----------------------------------------------------';
        SET @batch_start_time = GETDATE();
        PRINT '1. Loading CRM Tables'
        PRINT '----------------------------------------------------';

        -- Load data to brz.brz_crm_cust_info
        SET @start_time = GETDATE();
        PRINT '>> Truncating tbl: brz.brz_crm_cust_info';
        TRUNCATE TABLE brz.brz_crm_cust_info;
        PRINT '>> Inserting data into: brz.brz_crm_cust_info';
        BULK INSERT brz.brz_crm_cust_info
        FROM 'C:\SQL_Learning\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '1252',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -----------------------';

        -- Load data to brz.brz_crm_cust_info
        SET @start_time = GETDATE();
        PRINT '>> Truncating tbl: brz.brz_crm_prd_info';
        TRUNCATE TABLE brz.brz_crm_prd_info;
        PRINT '>> Inserting data into: brz.brz_crm_prd_info';
        BULK INSERT brz.brz_crm_prd_info
        FROM 'C:\SQL_Learning\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '1252',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -----------------------';

        -- Load data to brz.brz_crm_sales_details
        SET @start_time = GETDATE();
        PRINT '>> Truncating tbl: brz.brz_crm_sales_details';
        TRUNCATE TABLE brz.brz_crm_sales_details;
        PRINT '>> Inserting data into: brz.brz_crm_sales_details';
        BULK INSERT brz.brz_crm_sales_details
        FROM 'C:\SQL_Learning\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '1252',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -----------------------';

        PRINT '----------------------------------------------------';
        PRINT '2. Loading ERP Tables';
        PRINT '----------------------------------------------------';

        -- Load data to brz.brz_erp_cust_az12
        SET @start_time = GETDATE();
        PRINT'>> Truncating tbl: brz.brz_erp_cust_az12';
        TRUNCATE TABLE brz.brz_erp_cust_az12;
        PRINT'>> Inserting data into: brz.brz_erp_cust_az12';
        BULK INSERT brz.brz_erp_cust_az12
        FROM 'C:\SQL_Learning\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '1252',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -----------------------';

        -- Load data to brz.brz_erp_loc_a101
        SET @start_time = GETDATE();
        PRINT'>> Truncating tbl: brz.brz_erp_loc_a101';
        TRUNCATE TABLE brz.brz_erp_loc_a101;
        PRINT'>> Inserting data into: brz.brz_erp_loc_a101';
        BULK INSERT brz.brz_erp_loc_a101
        FROM 'C:\SQL_Learning\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '1252',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -----------------------';

        -- Load data to brz.brz_erp_px_cat_g1v2
        SET @start_time = GETDATE();
        PRINT'>> Truncating tbl: brz.brz_erp_px_cat_g1v2';
        TRUNCATE TABLE brz.brz_erp_px_cat_g1v2;
        PRINT'>> Inserting data into: brz.brz_erp_px_cat_g1v2';
        BULK INSERT brz.brz_erp_px_cat_g1v2
        FROM 'C:\SQL_Learning\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '1252',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -----------------------';

        SET @batch_end_time = GETDATE();
        PRINT '====================================================';
        PRINT 'Loading Bronze layer is completed';
        PRINT 'Total load duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '====================================================';

    END TRY
    BEGIN CATCH
        PRINT '----------------------------------------------------'
        PRINT 'ERROR OCCCURED DURING LOADING BRONZE LAYER'
        PRINT 'Error Message' + ERROR_MESSAGE();
        PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '----------------------------------------------------'
    END CATCH

END;
