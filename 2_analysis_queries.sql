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