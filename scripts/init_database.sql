/* 
==================================================================
Creating Database and Schemas
==================================================================
Script Pupose:
	This Script creates a new database 'DataWarehouse' and sets up 
	three schemas within the database: 'bronze', 'silver' and 'gold'.

This script will not be executed if you already have a database with name 'DataWarehouse'. */

-- Creating Database 'DataWarehouse'

Use Master;

Create Database DataWarehouse;

Use DataWarehouse;

-- Creating Schemas

Create Schema bronze;
Go
Create Schema silver;
Go
Create Schema gold;
Go
