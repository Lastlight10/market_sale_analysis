# Market Sales Dataset Analysis

##### Dataset provided by [Rohit Sahoo](https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting) from Kaggle.

## Dataset Collection and Cleaning

### Overview

This file provides the overview of the data cleaning process and data collection. In here, the data analyst provided the steps and their explanation for the queries and their purpose. Using SQL, the data were examined for anomalous values, and necessary corrections were applied.

### Data Collection

The dataset was provided from a Kaggle dataset provider, [Rohit Sahoo](https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting). The dataset was imported as a CSV file into MySQL Workbench where the data analyst used SQL to perform data queries. It was imported into a schema called `sales_data` with a table of `market_sales`. The analyst used the following query to import the data:

```
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
```
### Data Cleaning and Preparation

In this section, the data analyst examined the dataset for anomalous values, missing values, or any errors that may require corrections.

#### Table Structure  
The table is structured based on the CSV file. The MySQL Workbench imported the file, so the relationships and constraints are not included such as foreign relation to other tables, specific data types, or constraints. The analyst used the followind query to display some of the table's values:

```
SELECT * FROM market_sales LIMIT 5;
```

The query resulted into a table showing the first five rows:

| Row ID | Order ID | Order Date | Ship Date | Ship Mode | Customer ID | Customer Name | Segment | Country | City | State | Postal Code | Region | Product ID | Category | Sub-Category | Product Name | Sales |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | CA-2017-152156 | 08/11/2017 | 11/11/2017 | Second Class | CG-12520 | Claire Gute | Consumer | United States | Henderson | Kentucky | 42420 | South | FUR-BO-10001798 | Furniture | Bookcases | Bush Somerset Collection Bookcase | 261.96 |
| 2 | CA-2017-152156 | 08/11/2017 | 11/11/2017 | Second Class | CG-12520 | Claire Gute | Consumer | United States | Henderson | Kentucky | 42420 | South | FUR-CH-10000454 | Furniture | Chairs | Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back | 731.94 |
| 3 | CA-2017-138688 | 12/06/2017 | 16/06/2017 | Second Class | DV-13045 | Darrin Van Huff | Corporate | United States | Los Angeles | California | 90036 | West | OFF-LA-10000240 | Office Supplies | Labels | Self-Adhesive Address Labels for Typewriters by Universal | 14.62 |
| 4 | US-2016-108966 | 11/10/2016 | 18/10/2016 | Standard Class | SO-20335 | Sean O'Donnell | Consumer | United States | Fort Lauderdale | Florida | 33311 | South | FUR-TA-10000577 | Furniture | Tables | Bretford CR4500 Series Slim Rectangular Table | 957.5775 |
| 5 | US-2016-108966 | 11/10/2016 | 18/10/2016 | Standard Class | SO-20335 | Sean O'Donnell | Consumer | United States | Fort Lauderdale | Florida | 33311 | South | OFF-ST-10000760 | Office Supplies | Storage | Eldon Fold 'N Roll Cart System | 22.368 |
#### Null Values

The data analyst examined the dataset for null values my making an SQL query that counts the null values for each column.

```
USE sales_data;
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

```
The results were compiled as a csv file and resulted in all of the columns having values.
| null_row_id | null_order_id | null_order_date | null_ship_date | null_ship_mode | null_customer_id | null_customer_name | null_segment | null_country | null_city | null_state | null_postal_code | null_region | null_product_id | null_category | null_sub_category | null_product_name | null_sales |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

For the next process, the data analyst examined each column for anomalous values, and their descriptive values. Starting from the leftmost column to the right.

#### RowID

The column serves as the primary key for each row. The column was analyzed using the following SQL query:

```
SELECT
  MAX(`RowID`) AS max_row_id,
  MIN(`RowID`) AS min_row_id,
  COUNT(*) As rows_count
FROM market_sales;
```
The results are the following:
| max_row_id | min_row_id | rows_count |
| :--- | :--- | :--- |
| 9800 | 1 | 9800 |

The results show that the `Row ID` starts from 1 up to 9800, considering that the first five `Row IDs` show an increment of 1 before the next row, this column as an auto-increment function and serves as the primary key for each row.

#### OrderID

This refers to the `Order ID` made when a customer ordered a product. The formatting of the `Order ID` suggests that the first two letters refer to the country, `CA` for Canada and `US` for United States followed by the year  The column was analyzed using the following SQL query:

```
SELECT
  MAX(`OrderID`) AS max_order_id,
  MIN(`OrderID`) AS min_order_id,
  COUNT(*) As rows_count
FROM market_sales;
```
The results of the query above are:
| max_order_id | min_order_id | rows_count |
| :--- | :--- | :--- |
| US-2018-169551 | CA-2015-100006 | 9800 |  

The results show that the values of the `OrderIDs` and how many rows there are. Since the `OrderIDs` are in a specific format, the data analyst used the following query to count all the rows that are not followind the specfic format given:

```
-- Count the OrderID that is not in this format
SELECT COUNT(`OrderID`) AS other_format
FROM market_sales
WHERE `OrderID` NOT REGEXP '^(US|CA)-[0-9]{4}-[0-9]+$';
```
The results were the following:
| other_format |
|---|
| 0 |

Since there are no values with a different format, or missing values, the column can be considered clean.

#### OrderDate

The column refers to the date the order was made. The date is parsed on the importation of the data into the MySQL Workbench. The data analyst used the following code:
```
-- Prepare and Examine Order Date
SELECT
	MIN(`OrderDate`) AS min_date,
    MAX(`OrderDate`) AS max_date,
    COUNT(`OrderDate`) as count_date
FROM market_sales;
```
The results of the query were:
| min_date | max_date | count_date |
| :--- | :--- | :--- |
| 2015-01-03 | 2018-12-30 | 9800 |

The results suggests that the dates are now stored in this format and the count of rows is still 9800. If there are any formatting error, the those cell value will not be imported and shown as NULL. However, the rows count is still 9800, meaning all the rows are clean and intact for analysis.

#### ShipDate

The column refers to the date when the product was shipped for delivery. The date is parsed on the importation of the data into the MySQL Workbench. The data analyst used the following code to examine the column:

```
SELECT
	MIN(`ShipDate`) AS min_date,
    MAX(`ShipDate`) AS max_date,
    COUNT(`OrderDate`) as count_date
FROM market_sales;
```
The results of the SQL query are:
| min_date | max_date | count_date |
| :--- | :--- | :--- |
| 2015-01-07 | 2019-01-05 | 9800 |

The results show that the column has all the 9800 rows and their dates are parsed for the data type. The `ShipDate` must not be before the `OrderDate`. The analyst used the following code to examine the `OrderDate` and `ShipDate`:

```
-- Check if there are rows where OrderDate > ShipDate
SELECT COUNT(*) AS shipped_before_order
FROM market_sales
WHERE `OrderDate` > `ShipDate`
```

The results of the query were:
| shipped_before_order |
|---|
| 0 |

This means that there are no rows where the `ShipDate` is older than the `OrderDate`. This means that the column can be considered clean and prepared for analysis.

#### ShipMode

This column represents the shipping mode for each order. There are a total of four types given by the following SQL query:

```
SELECT
DISTINCT(`ShipMode`) AS ship_mode
FROM market_sales
GROUP BY `ShipMode`;
```
The results of this query are:
| ship_mode |
| :--- |
| Second Class |
| Standard Class |
| First Class |
| Same Day |

The data analyst examined the count for each type of shipping mode and their sum. The query and results are:
```
-- Find the count for each types and total
SELECT *, (count_second_class + count_standard_class + count_first_class + count_same_day) AS total_count
FROM(
	SELECT
		SUM(CASE WHEN `ShipMode` = 'Second Class' THEN 1 ELSE 0 END) AS count_second_class,
		SUM(CASE WHEN `ShipMode` = 'Standard Class' THEN 1 ELSE 0 END) AS count_standard_class,
		SUM(CASE WHEN `ShipMode` = 'First Class' THEN 1 ELSE 0 END) AS count_first_class,
		SUM(CASE WHEN `ShipMode` = 'Same Day' THEN 1 ELSE 0 END) AS count_same_day
	FROM market_sales
) AS sub
```
| count_second_class | count_standard_class | count_first_class | count_same_day | total_count |
| :--- | :--- | :--- | :--- | :--- |
| 1902 | 5859 | 1501 | 538 | 9800 |

The count for each type of shipping mode accounts to the total of rows and their sum. The column can be considered clean and prepared for analysis.

#### CustomerID

The column represents the customer and their unique id. The analyst examined the column with the following query:
```
-- Prepare and Examine CustomerID
SELECT 
	COUNT(DISTINCT(`CustomerID`)) AS customer_count,
	COUNT(*) AS customer_rows
FROM market_sales;
```
The results of the SQL query are the following:
| customer_count | customer_rows |
| :--- | :--- |
| 793 | 9800 |  

The results suggests a total of `793` customers with `9800` products sold. Each `CustomerID` follows a specific format of initials and numbers, to check if all `CustomerID` follows this format, the data analyst used:
```
SELECT COUNT(`CustomerID`) AS customerid_wrong_format
FROM market_sales
WHERE `CustomerID` NOT REGEXP '^[A-Z]{2}-[0-9]{5}$';
```
The results of the query are:
| customerid_wrong_format |
| :--- |
| 0 |

The results suggests that all of the `CustomerID` follows the format properly. This means that the column is clean and prepared to be analyzed.

#### CustomerName

The column refers to the customer's name. The data analyst reviewed the column using the following SQL query:
```
-- Prepare and examine Customer Name
SELECT 
	COUNT(DISTINCT(`CustomerName`)) AS unique_customers,
	COUNT(`CustomerName`) AS total_count
FROM market_sales;
```
The results of the query are:
| unique_customers | total_count |
| :--- | :--- |
| 793 | 9800 |

This shows that there are `793` customer names with `9800` rows of records. Since the number of `CustomerID` matches with the number of `CustomerName`, it can be said that the names are valid and ready for data analysis.

#### Segment