/*
=================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
=================================================================================
Script Purpose:
	This stored procedure loads data into the 'bronze' schema from external CSV files.
	It performs the following actions:
	- Truncates the bronze tables before loading data.
	- Uses the 'BULK INSERT' command to load data from csv Files to bronze tables.

Parameters:
	None.
	This stored procedure does not accepts any parameter or returns any values.
	
Usage Example:
	EXEC bronze.load_bronze;

=================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '===============================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '===============================================================';

		PRINT '---------------------------------------------------------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '---------------------------------------------------------------';

		SET @start_time = GETDATE ();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK Insert bronze.crm_cust_info
		FROM 'D:\SQL Project\sql-data-warehouse-project-main\01_datasets\source_crm\cust_info.csv'
		WITH (
			FirstRow = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE ();
		PRINT '>> Load Duration: ' + CAST (Datediff(second, @start_time, @end_time) as NVARCHAR) + 'seconds';
		PRINT '>> -----------------------';

		SET @start_time = GETDATE ();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK Insert bronze.crm_prd_info
		FROM 'D:\SQL Project\sql-data-warehouse-project-main\01_datasets\source_crm\prd_info.csv'
		WITH (
			FirstRow = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE ();
		PRINT '>> Load Duration: ' + CAST (Datediff(second, @start_time, @end_time) as NVARCHAR) + 'seconds';
		PRINT '>> -----------------------';

		SET @start_time = GETDATE ();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK Insert bronze.crm_sales_details
		FROM 'D:\SQL Project\sql-data-warehouse-project-main\01_datasets\source_crm\sales_details.csv'
		WITH (
			FirstRow = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE ();
		PRINT '>> Load Duration: ' + CAST (Datediff(second, @start_time, @end_time) as NVARCHAR) + 'seconds';
		PRINT '>> -----------------------';

		PRINT '---------------------------------------------------------------';
		PRINT 'LOADING ERP TABLES';
		PRINT '---------------------------------------------------------------';

		SET @start_time = GETDATE ();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK Insert bronze.erp_cust_az12
		FROM 'D:\SQL Project\sql-data-warehouse-project-main\01_datasets\source_erp\cust_az12.csv'
		WITH (
			FirstRow = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE ();
		PRINT '>> Load Duration: ' + CAST (Datediff(second, @start_time, @end_time) as NVARCHAR) + 'seconds';
		PRINT '>> -----------------------';

		SET @start_time = GETDATE ();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK Insert bronze.erp_loc_a101
		FROM 'D:\SQL Project\sql-data-warehouse-project-main\01_datasets\source_erp\loc_a101.csv'
		WITH (
			FirstRow = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE ();
		PRINT '>> Load Duration: ' + CAST (Datediff(second, @start_time, @end_time) as NVARCHAR) + 'seconds';
		PRINT '>> -----------------------';

		SET @start_time = GETDATE ();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK Insert bronze.erp_px_cat_g1v2
		FROM 'D:\SQL Project\sql-data-warehouse-project-main\01_datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FirstRow = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE ();
		PRINT '>> Load Duration: ' + CAST (Datediff(second, @start_time, @end_time) as NVARCHAR) + 'seconds';
		PRINT '>> -----------------------';
		SET @batch_end_time = GETDATE();
		PRINT '===================================================='
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '   -Total Load Duration: '  + CAST (Datediff(second, @batch_start_time, @batch_end_time) as NVARCHAR) + 'seconds';
	END TRY
	BEGIN CATCH
	PRINT '========================================================'
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'Error Message' + ERROR_MESSAGE();
	PRINT 'Error Number' + CAST (ERROR_NUMBER() as NVARCHAR)
	PRINT 'Error Number' + CAST (ERROR_STATE() as NVARCHAR)
	PRINT '========================================================'
	END CATCH
END
