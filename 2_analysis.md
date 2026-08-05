# Market Sales Dataset Analysis

##### Dataset provided by [Rohit Sahoo](https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting) from Kaggle.

## Dataset Analysis and Exploration

### Overview

This file provides the overview of the data analysis and exploration process of the given dataset. In here, the analyst examined the columns for to answer the following questions. The answers are explained and displayed through SQL querying and data visualization.

### Data Analysis and Exploration

#### Questions

In this data analysis, the analyst is determined to answer the following questions presented below:

1. Which product category and sub-category generate the highest sales?
2. Which regions are underperforming and might benefit from targeted marketing?
3. What is the distribution of orders across different customer segments (Consumer, Corporate, Home Office)?
4. What is the average order value, and how does it vary by category?
5. What is the average time between order date and ship date, and does it vary by ship mode or region?
6. Is there a relationship between customer segment and preferred product category?
7. What are the top 10 customers by total sales, and how much do they contribute to overall revenue (Pareto analysis)?
8. Which shipping mode is most commonly used?
9. Can you build a time-series model (ARIMA, Prophet, exponential smoothing) to forecast next quarter's sales?
10. Can you provide a forecast for the next quarter?
    
#### Exploratory Data Analysis

##### 1. Which product category and sub-category generate the highest sales?  

For this question, the data analyst determines that an SQL query to gather the total sales from each product categories and sub categories, then display their highest sales. The data analysts used the following SQL query:
```
-- 1. Which product category and sub-category generate the highest sales?  
SELECT
	Category,
    SubCategory,
    SUM(Sales) AS total_sale
FROM market_sales
GROUP BY Category, SubCategory
ORDER BY total_sale DESC;
```
The results of the query are saved as `1_category_subcategory_highest_sales.csv` in the folder `results/data_analysis`. The results of the query are:  

| Category | SubCategory | total_sale |
| :--- | :--- | :--- |
| Technology | Phones | 327782.4480 |
| Furniture | Chairs | 322822.7310 |
| Office Supplies | Storage | 219343.3920 |
| Furniture | Tables | 202810.6280 |
| Office Supplies | Binders | 200028.7850 |
| Technology | Machines | 189238.6310 |
| Technology | Accessories | 164186.7000 |
| Technology | Copiers | 146248.0940 |
| Furniture | Bookcases | 113813.1987 |
| Office Supplies | Appliances | 104618.4030 |
| Furniture | Furnishings | 89212.0180 |
| Office Supplies | Paper | 76828.3040 |
| Office Supplies | Supplies | 46420.3080 |
| Office Supplies | Art | 26705.4100 |
| Office Supplies | Envelopes | 16128.0460 |
| Office Supplies | Labels | 12347.7260 |
| Office Supplies | Fasteners | 3001.9600 |

The results show that `Technology, Phones` have the highest total sales followed closely by `Furniture, Chairs`. Using PowerBI, the analyst visualized the data:



##### 2. Which regions are underperforming and might benefit from targeted marketing?

The analyst used the total for all the sales as the benchmark average to compare the average sales of each region. The region is considered to be underperforming if the averages sales fall below the lower quantile of the total sales. The analyst used the following SQL query:
```
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
```

The analyst used CTE to get the sales and their row number, and to get the index of the lower quartile. The analyst then used the index of the lower quartile to identify the the indexed row with the same value. The results are:
| Sales | row_num |
| :--- | :--- |
| 17.2480 | 2450 |

The results show that the lower quartile is the value of `17.2480`. The results are saved as `2_lower_quartile.csv` in the folder `results/data_analysis`. The sales lower than the lower quartile can be considered underperforming. The data analysis used the results to find these sales:
```
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
```

The query is meant to get the average sales of each region, the second expression will return the `RegionAVG` but with their respective quartile percentages. The last part of the query is where the analyst only selected all the results under or equal to the lower quartile. The results of the query are:
| Region | avg_sales |
| :--- | :--- |
| Central | 216.35788898 |

This means that the `Central` region has been underperforming and would benefit from a marketing campaign. The results are saved as `2_underperforming_region.csv` in the folder `results/data_analysis`.

##### 3. What is the distribution of orders across different customer segments (Consumer, Corporate, Home Office)?

In this question, the data analyst used SQL queries to find the distribution of the rows into the three segments. The following SQL query was used:
```

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
```
The queries gathers all the seqments and their counts into `SegmentsCount`, and then the query counts the total rows. After that, the last expression gathers the data from the `SegmentsCount` where the rows_count is dividided by the `total_rows` and muliplied by 100 to get the percentage. The results are the following:
| Segment | rows_count | percentage |
| :--- | :--- | :--- |
| Consumer | 5101 | 52.0510 |
| Corporate | 2953 | 30.1327 |
| Home Office | 1746 | 17.8163 |

The results show that majority of the orders came from the segment `Consumer`, followed by `Corporate` then `Home Office`. To further visualize the results, the data analyst used PowerBI to display the data:


The results were saved as `3_distribution_of_segments.csv` in the folder `results/data_analysis`.

##### 4. What is the average order value, and how does it vary by category?

The data analyst determined the average sales by category based on their `OrderID` since customers can purchase multiple products on one order. The data analyst used the following SQL query:
```
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
```
The SQL query selects the `OrderID`, `Category`, and the sum of the `Sales` per order as order value and groups them together based on `OrderID` and `Category`. The query then analyzes the average of those order values based on their category and the result are:
| Category | avg_order_value |
| :--- | :--- |
| Furniture | 421.92158408 |
| Office Supplies | 191.89943798 |
| Technology | 544.73724358 |

The results how that for the `Category` of  `Furniture`, it has an average order value of `421.92158408`, `Office Supplies` has an average order value of `191.89943798` and `Technology` has an average of `544.73724358`. The results are saves as `4_average_value_per_order.csv` in the folder `results/data_analysis`.