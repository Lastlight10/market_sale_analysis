SELECT * FROM market_sales LIMIT 10;

SELECT
	SUM(CASE WHEN `Row ID` IS NULL THEN 1 ELSE 0 END) AS null_row_id,
    SUM(CASE WHEN `Order ID` IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN `Order Date` IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN `Ship Date` IS NULL THEN 1 ELSE 0 END) AS null_ship_date,
    SUM(CASE WHEN `Ship Mode` IS NULL THEN 1 ELSE 0 END) AS null_ship_mode,
    SUM(CASE WHEN `Customer ID` IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN `Customer Name` IS NULL THEN 1 ELSE 0 END) AS null_customer_name,
    SUM(CASE WHEN `Segment` IS NULL THEN 1 ELSE 0 END) AS null_segment,
    SUM(CASE WHEN `Country` IS NULL THEN 1 ELSE 0 END) AS null_country,
    SUM(CASE WHEN `City` IS NULL THEN 1 ELSE 0 END) AS null_city,
    SUM(CASE WHEN `State` IS NULL THEN 1 ELSE 0 END) AS null_state,
    SUM(CASE WHEN `Postal Code` IS NULL THEN 1 ELSE 0 END) AS null_postal_code,
    SUM(CASE WHEN `Region` IS NULL THEN 1 ELSE 0 END) AS null_region,
    SUM(CASE WHEN `Product ID` IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN `Category` IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN `Sub-Category` IS NULL THEN 1 ELSE 0 END) AS null_sub_category,
    SUM(CASE WHEN `Product Name` IS NULL THEN 1 ELSE 0 END) AS null_product_name,
    SUM(CASE WHEN `Sales` IS NULL THEN 1 ELSE 0 END) AS null_sales
    
FROM market_sales;