-- 1. Which product category and sub-category generate the highest sales?  
SELECT
	Category,
    SubCategory,
    SUM(Sales) AS total_sale
FROM market_sales
GROUP BY Category, SubCategory
ORDER BY total_sale DESC;

-- 2. Which regions are underperforming and might benefit from targeted marketing?
WITH RegionAVG AS (
	-- This will return the averages of each region
	SELECT Region, AVG(Sales) AS avg_sales
    FROM market_sales
    GROUP BY REGION
), Ranked AS (
	-- This will return the rows from RegionAVG based on pct_rank
	SELECT *,
    PERCENT_RANK() OVER (ORDER BY avg_sales) as pct_rank
    FROM RegionAVG
)

SELECT Region, avg_sales
FROM Ranked
WHERE pct_rank <= 0.25
ORDER BY avg_sales ASC;

-- 3. What is the distribution of orders across different customer segments (Consumer, Corporate, Home Office)?
With SegmentsCount AS (
	SELECT
    Segment,
    COUNT(*) AS rows_count
    FROM market_sales
    GROUP BY Segment
), TotalRows AS (
	SELECT COUNT(*) AS total_rows
	FROM market_sales
), SegmentsPercentages AS (
	SELECT
    sg.Segment, sg.rows_count,(sg.rows_count / tr.total_rows) * 100 AS percentage
    FROM SegmentsCount AS sg, TotalRows AS tr
)

SELECT * FROM SegmentsPercentages;

-- 4. What is the average order value, and how does it vary by category?
WITH TotalSalesPerOrder AS (
	SELECT
		OrderID,
		Category,
		SUM(Sales) AS total_sale_per_order
	FROM market_sales
	GROUP BY OrderID, Category
)
SELECT Category, AVG(total_sale_per_order) AS avg_order_value
FROM TotalSalesPerOrder
GROUP BY Category;

-- 5.  What is the average time between order date and ship date, and does it vary by ship mode or region?
-- For the overall average:
SELECT
	AVG(ShipDate - OrderDate) AS overall_avg_days
FROM market_sales;

-- For the ShipMode
SELECT
    ShipMode,
	AVG(ShipDate - OrderDate) AS avg_days
FROM market_sales
GROUP BY ShipMode
ORDER BY avg_days DESC;

-- For the Region
SELECT
    Region,
	AVG(ShipDate - OrderDate) AS avg_days
FROM market_sales
GROUP BY Region
ORDER BY avg_days DESC;

-- 6. Is there a relationship between customer segment and preferred product category?
SELECT
	Segment,
	Category,
	COUNT(*) AS count
FROM market_sales
GROUP BY Segment, Category
ORDER BY Segment, count DESC;

-- 7. What are the top 10 customers by total sales, and how much do they contribute to overall revenue (Pareto analysis)?

WITH customer_sales AS (
    SELECT
        CustomerID,
        CustomerName,
        SUM(Sales) AS total_sales
    FROM market_sales
    GROUP BY CustomerID, CustomerName
),
overall AS (
    SELECT SUM(total_sales) AS grand_total
    FROM customer_sales
)
SELECT
    cs.CustomerID,
    cs.CustomerName,
    cs.total_sales,
    ROW_NUMBER() OVER (ORDER BY total_sales DESC) AS customer_rank,
    ROUND(cs.total_sales * 100.0 / o.grand_total, 2) AS pct_of_total,
    ROUND(
        SUM(cs.total_sales) OVER (ORDER BY cs.total_sales DESC) * 100.0 / o.grand_total,
        2
    ) AS cumulative_pct
FROM customer_sales cs
CROSS JOIN overall o
ORDER BY cs.total_sales DESC;
-- LIMIT 10;

-- 8. Which shipping mode is most commonly used?
SELECT
	ShipMode,
    COUNT(*) AS count
FROM market_sales
GROUP BY ShipMode
ORDER BY count DESC;