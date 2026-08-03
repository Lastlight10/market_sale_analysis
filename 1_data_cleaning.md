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

The column represents the type of consumers. To examine the column, the data analyst used the following SQL query:

```
SELECT 
	DISTINCT(`Segment`) AS unique_segments
FROM market_sales;
```
The results of the query are:
| unique_segments |
| :--- |
| Consumer |
| Corporate |
| Home Office |

The results suggest three types of `Segments`. To examine them further, the analyst used the following query:
```
SELECT 
	DISTINCT(`Segment`) AS unique_segments,
    SUM(CASE WHEN `Segment` = 'Consumer' THEN 1 ELSE 0 END) AS consumer_count,
    SUM(CASE WHEN `Segment` = 'Corporate' THEN 1 ELSE 0 END) AS corporate_count,
    SUM(CASE WHEN `Segment` = 'Home Office' THEN 1 ELSE 0 END) AS home_office_count
FROM market_sales;
```
The results of the query above are:
| consumer_count | corporate_count | home_office_count | total_count |
| :--- | :--- | :--- | :--- |
| 5101 | 2953 | 1746 | 9800 |

The `Segment` are divided into three types with their respective counts on how much they appear in the rows. Their total results to 9800 which is equal to the total rows, meaning that all the values of the columns match the three types, making the column fit for analysis.

#### Country

The column represents the shipping address's country of the consumer. The data analyst examined the data using the following SQL query:
```
SELECT
	DISTINCT(`Country`) as unique_countries,
    SUM(CASE WHEN `Country` = 'United States' THEN 1 ELSE 0 END) as count_country
FROM market_sales
GROUP BY `Country`;
```
The results show the countries and the count for each in the dataset. Currently, there is only one country that showed up on all 9800 rows. The data can be used for data analysis.

#### City 

The column represents the city where the customer's shipping address is located. The data analysts examined the dataset using the following SQL query:
```
SELECT
	COUNT(DISTINCT(`City`)) AS unique_cities,
    COUNT(*) AS rows_count
FROM market_sales;
```
The results of the following are:
| unique_cities | rows_count |
| :--- | :--- |
| 529 | 9800 |

The results show 529 unique cities among the records. Since the city names can be varied in names, but only have alphaberical letters and spaces, the analyst used the following code to check if all the cities are in the proper format:
```
-- Find City with improper format
SELECT COUNT(*) AS cities_wrong_format
FROM market_sales
WHERE `City` NOT REGEXP '^[a-zA-Z ]+$';
```

The results are:
| cities_wrong_format |
| :--- |
| 0 |

This suggests that all of the city names are in proper format making the column ready for analysis.

#### PostalCode

This column represents the postal code for the shipping address of the customer. Postal codes can have varying length. The data analyst used the following code considering this condition:
```
-- Check for Postal Code with wrong format
SELECT 
    MIN(LENGTH(`PostalCode`)) AS min_length,
    MAX(LENGTH(`PostalCode`)) AS max_length
FROM market_sales;
```

The query is meant to show the maximum and minimum length of the postal codes. The results are:

| min_length | max_length |
| :--- | :--- |
| 0 | 5 |

The postal codes are dividied into having different lengths with one of them having `0` length. The eariler analysis identified that there are no `NULL` values therefore in this case, they must be emptry strings. The analyst use the following code to transform this emptry strings into null values:
```
SET SQL_SAFE_UPDATES = 0; -- Allow updates to happen at bulk

-- Now run your update statement:
UPDATE market_sales
SET `PostalCode` = NULLIF(TRIM(`PostalCode`), '')
WHERE TRIM(`PostalCode`) = '';

-- Optional: Turn safe updates back on afterward
SET SQL_SAFE_UPDATES = 1; -- Disallo bulk updates
```
Now to determine the results for the count for each length of postal codes, the data analyst used the following:
```
SELECT *,
	(null_length + four_lengths + five_lengths) AS total_count
FROM (
	SELECT
		SUM(CASE WHEN `PostalCode` IS NULL THEN 1 ELSE 0 END) AS null_length,
		SUM(CASE WHEN LENGTH(`PostalCode`) = 4 THEN 1 ELSE 0 END) AS four_lengths,
		SUM(CASE WHEN LENGTH(`PostalCode`) = 5 THEN 1 ELSE 0 END) AS five_lengths
	FROM market_sales
    WHERE `PostalCode` REGEXP '^[0-9]{4,5}$' OR `PostalCode` IS NULL
) AS sub;
```
The results of the query are:
| null_length | four_lengths | five_lengths | total_count |
| :--- | :--- | :--- | :--- |
| 11 | 429 | 9360 | 9800 |

The `PostalCode` column now consists of postal codes with null values, and values with 4 or 5 length and follows the numeric format or are `NULL`. The data can now bew considered clean and ready for analysis.

#### Null Values Update

Since the data analyst discovered the empty strings and converted them into `NULL` values, the null values are now the following:

| null_row_id | null_order_id | null_order_date | null_ship_date | null_ship_mode | null_customer_id | null_customer_name | null_segment | null_country | null_city | null_state | null_postal_code | null_region | null_product_id | null_category | null_sub_category | null_product_name | null_sales |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 11 | 0 | 0 | 0 | 0 | 0 | 0 |

#### Region

The column represents the region of the customer. The data analyst used the following SQL query:
```
SELECT
	`Region` AS unique_regions,
    COUNT(*) AS region_count
FROM market_sales
GROUP BY `Region`
UNION ALL
SELECT
	'Total' AS unique_regions,
    COUNT(*) AS region_count
FROM market_sales;
```

The results of the query are:
| unique_regions | region_count |
| :--- | :--- |
| South | 1598 |
| West | 3140 |
| Central | 2277 |
| East | 2785 |
| Total | 9800 |

The results show four regions with each unique counts, totalling up to `9800` rows. This suggests that all the values are split up between these 4 regions and there are no missing or anomalies in the values. The column is prepared for data analysis.

#### ProductID

The column represents the id of the products purchased. The data analyst examined the column using the SQL query:
```
-- Prepare and examine ProductID
SELECT `ProductID` FROM market_sales LIMIT 5;
```
| ProductID |
| :--- |
| FUR-BO-10001798 |
| FUR-CH-10000454 |
| OFF-LA-10000240 |
| FUR-TA-10000577 |
| OFF-ST-10000760 |

The results showed 5 example of `ProductID` following a certain format, to determine how many values are in this format, the analyst used the following query:
```
SELECT
	COUNT(*) AS total_rows
FROM market_sales
WHERE `ProductID` REGEXP '^[A-Z]{3}-[A-Z]{2}-[0-9]+$';
```
The results are the following:
| total_rows |
| :--- |
| 9800 |

The results suggests that all of the `ProductID` are in proper format, making the column cleaned and prepared for data analysis.

#### Category

The column represents the categories in which the product falls into. The data analyst examined the data using the following query:
```
SELECT
	`Category` AS unique_category,
	COUNT(*) AS rows_count
FROM market_sales
GROUP BY `Category`
UNION ALL
SELECT
	'TOTAL' AS unique_category,
    COUNT(*) AS rows_count
FROM market_sales;
```
The results of the SQL query are:
| unique_category | rows_count |
| :--- | :--- |
| Furniture | 2078 |
| Office Supplies | 5909 |
| Technology | 1813 |
| TOTAL | 9800 |

The results show that the products are divided into three main categories and totalling up to `9800`. This suggests that all the values in the `Category` column are viable for data analysis.

#### SubCategory
The column represents the sub categories the products are under in. The data analyst used the following SQL query:
```
-- Prepare and examine SubCategory
SELECT
	Category  AS unique_category,
    SubCategory AS unique_sub_category,
	COUNT(*) AS rows_count
FROM market_sales
GROUP BY Category, SubCategory
UNION ALL
SELECT
	'TOTAL' AS unique_category,
    'TOTAL' AS unique_sub_category,
    COUNT(*) AS rows_count
FROM market_sales
ORDER BY
(unique_category = 'TOTAL'),
unique_category,
unique_sub_category;
```
The results of the query are:
| unique_category | unique_sub_category | rows_count |
| :--- | :--- | :--- |
| Furniture | Bookcases | 226 |
| Furniture | Chairs | 607 |
| Furniture | Furnishings | 931 |
| Furniture | Tables | 314 |
| Office Supplies | Appliances | 459 |
| Office Supplies | Art | 785 |
| Office Supplies | Binders | 1492 |
| Office Supplies | Envelopes | 248 |
| Office Supplies | Fasteners | 214 |
| Office Supplies | Labels | 357 |
| Office Supplies | Paper | 1338 |
| Office Supplies | Storage | 832 |
| Office Supplies | Supplies | 184 |
| Technology | Accessories | 756 |
| Technology | Copiers | 66 |
| Technology | Machines | 115 |
| Technology | Phones | 876 |
| TOTAL | TOTAL | 9800 |

The data shows the subcategories and their counts. The sub categories are under the categories and with their total count combined, the rows add up to `9800` meaning, all the rows are valid for data analysis.

#### ProductName

The column represents the product name. Since the product names can have a variety of format, the analyst examined the column for null values. The data analyst used the following SQL query to examine the data:
```
-- Prepare and examine ProductName
SELECT COUNT(*) AS null_product_name
FROM market_sales
WHERE `ProductName` IS NULL OR `ProductName` = '';
```
| null_product_name |
| :--- |
| 0 |

The results show that all of the `ProductName` have valid values in their cells. This makes the column ready for data analysis.

#### Sales 
The column represents the amount of sales the products made. Since the data are stored as floats, the analyst has decided to count the rows where the value is greater than 0. The analyst used the following SQL query:
```
-- Prepare and examine Sales
SELECT COUNT(*) AS rows_count
FROM market_sales
WHERE `Sales` >= 0;
```
| rows_count |
| :--- |
| 9800 |

The results shows the number of rows that have values greater than 0. This number is `9800` which means that all the values are valid and ready for data analysis.