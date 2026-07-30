-- Import the data using MySQL Query
SET GLOBAL local_infile = 1; -- Allow local files to be loaded into the workbench
USE sales_data; -- Use this schema

-- Create the table here
CREATE TABLE market_sales (
  RowID INT,
  OrderID VARCHAR(20),
  OrderDate DATE,
  ShipDate DATE,
  ShipMode VARCHAR(30),
  CustomerID VARCHAR(20),
  CustomerName VARCHAR(100),
  Segment VARCHAR(30),
  Country VARCHAR(50),
  City VARCHAR(50),
  State VARCHAR(50),
  PostalCode VARCHAR(10),
  Region VARCHAR(20),
  ProductID VARCHAR(30),
  Category VARCHAR(50),
  SubCategory VARCHAR(50),
  ProductName VARCHAR(255),
  Sales DECIMAL(10,4)
);

-- Change path to your path to the dataset
LOAD DATA LOCAL INFILE 'path/to/train.csv' -- Load the CSV file
INTO TABLE market_sales -- Put the loaded data into this table
FIELDS TERMINATED BY ',' -- Field are separated by a comma
OPTIONALLY ENCLOSED BY '"' -- Some values are double quoted
LINES TERMINATED BY '\n' -- Refers to the next row
IGNORE 1 ROWS -- Ignore the first row (headers row)
(RowID, OrderID, @OrderDate, @ShipDate, ShipMode, CustomerID, CustomerName,
 Segment, Country, City, State, PostalCode, Region, ProductID, Category,
 SubCategory, ProductName, Sales)
SET -- Parse the string dates into proper data types
  OrderDate = STR_TO_DATE(@OrderDate, '%d/%m/%Y'),
  ShipDate  = STR_TO_DATE(@ShipDate, '%d/%m/%Y');

-- Use this database
USE sales_data;

-- Display first 10 rows
SELECT * FROM market_sales LIMIT 10;

-- Check Null values
SELECT
	SUM(CASE WHEN `RowID` IS NULL THEN 1 ELSE 0 END) AS null_row_id,
    SUM(CASE WHEN `OrderID` IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN `OrderDate` IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN `ShipDate` IS NULL THEN 1 ELSE 0 END) AS null_ship_date,
    SUM(CASE WHEN `ShipMode` IS NULL THEN 1 ELSE 0 END) AS null_ship_mode,
    SUM(CASE WHEN `CustomerID` IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN `CustomerName` IS NULL THEN 1 ELSE 0 END) AS null_customer_name,
    SUM(CASE WHEN `Segment` IS NULL THEN 1 ELSE 0 END) AS null_segment,
    SUM(CASE WHEN `Country` IS NULL THEN 1 ELSE 0 END) AS null_country,
    SUM(CASE WHEN `City` IS NULL THEN 1 ELSE 0 END) AS null_city,
    SUM(CASE WHEN `State` IS NULL THEN 1 ELSE 0 END) AS null_state,
    SUM(CASE WHEN `PostalCode` IS NULL THEN 1 ELSE 0 END) AS null_postal_code,
    SUM(CASE WHEN `Region` IS NULL THEN 1 ELSE 0 END) AS null_region,
    SUM(CASE WHEN `ProductID` IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN `Category` IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN `SubCategory` IS NULL THEN 1 ELSE 0 END) AS null_sub_category,
    SUM(CASE WHEN `ProductName` IS NULL THEN 1 ELSE 0 END) AS null_product_name,
    SUM(CASE WHEN `Sales` IS NULL THEN 1 ELSE 0 END) AS null_sales
    
FROM market_sales;

-- Prepare and Examine Row ID
SELECT
  MAX(`RowID`) AS max_row_id,
  MIN(`RowID`) AS min_row_id,
  COUNT(*) As rows_count
FROM market_sales;

-- Prepare and Examine Order ID
SELECT
  MAX(`OrderID`) AS max_row_id,
  MIN(`OrderID`) AS min_row_id,
  COUNT(*) As rows_count
FROM market_sales;
