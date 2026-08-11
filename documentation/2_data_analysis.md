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
9. Can you build a time-series model to forecast next quarter's sales?
10. Can you provide a forecast for the next year?
    
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

![Visual 1](/images/visualizations/visual_market_sales_data_analysis-images-0.jpg)

The results are saved as `1_category_subcategory_highest_sales.csv` in the `results/data_analysis` folder.

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

This means that the `Central` region has been underperforming and would benefit from a marketing campaign. The data analyst visualized the data using PowerBI:

![Visual 2](/images/visualizations/visual_market_sales_data_analysis-images-1.jpg)

The results are saved as `2_underperforming_region.csv` in the folder `results/data_analysis`.

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

![Visual 3](/images/visualizations/visual_market_sales_data_analysis-images-2.jpg)

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

The results how that for the `Category` of  `Furniture`, it has an average order value of `421.92158408`, `Office Supplies` has an average order value of `191.89943798` and `Technology` has an average of `544.73724358`. The results show a varied average order value where `Technology` is dominant, followed by `Furniture` and lastly, `Office Supplies`. The data are visualized with the image below:

![Visual 4](/images/visualizations/visual_market_sales_data_analysis-images-3.jpg)

The results are saves as `4_average_value_per_order.csv` in the folder `results/data_analysis`.

##### 5. What is the average time between order date and ship date, and does it vary by ship mode or region?

The data analyst used the avergae of the difference between the two dates for the overall data, by `ShipMode` and by `Region`. The analyst used the following SQL query:

For the overall average:
```
-- 5.  What is the average time between order date and ship date, and does it vary by ship mode or region?
-- For the overall average:
SELECT
	AVG(DATEDIFF(ShipDate, OrderDate)) AS overall_avg_days
FROM market_sales;
```

The query identifies the average of the differences in days between the `ShipDate` and the `OrderDate`. The results of the query are:
| overall_avg_days |
| :--- |
| 3.9611 |
The results show that it takes `3.9611` days for the average order to arrive. 

For the `ShipMode`, the data analyst used the following SQL query:
```
-- For the ShipMode
SELECT
    ShipMode,
	AVG(DATEDIFF(ShipDate, OrderDate)) AS avg_days
FROM market_sales
GROUP BY ShipMode
ORDER BY avg_days DESC;
```

The query shows the differences of between the `ShipDate` and `OrderDate` in days grouped by the `ShipMode` to analyze each of the average days for each type. The results of the query are the following:
| ShipMode | avg_days |
| :--- | :--- |
| Standard Class | 5.0084 |
| Second Class | 3.2492 |
| First Class | 2.1792 |
| Same Day | 0.0446 |

The results show the average length of time between the different shipping modes. `Standard Class` has the longest time with `5.0084` days, followed by `Second Class` with `3.2492` days, `First Class` with `2.1792` days and `Same Day` with `0.0446` days.

For each `Region`, the analyst used:
```
-- For the Region
SELECT
    Region,
	AVG(DATEDIFF(ShipDate, OrderDate)) AS avg_days
FROM market_sales
GROUP BY Region
ORDER BY avg_days DESC;
```
The query shows the differences of between the `ShipDate` and `OrderDate` in days grouped by the `Region` to analyze each of the average days for each type. The results of the query are the following:
| Region | avg_days |
| :--- | :--- |
| Central | 4.0659 |
| South | 3.9612 |
| West | 3.9303 |
| East | 3.9102 |

The results of the query shows that `Central` has the longest time with `4.0659` days. Followed by `South` with `3.9612` days, `West` with `3.9303` days and lastly, `East` with `3.9102` days. 

The results show that the average time between order and shipdate varies depending on the shipping mode and regions. The data are visualized in the image below:

![Visual 5](/images/visualizations/visual_market_sales_data_analysis-images-4.jpg)

The results are saved in as `5_overall_average_days.csv`, `5_ship_mode_average.csv`, and `5_region_average.csv` in the folder `results/data_analysis` respectively.

##### 6. Is there a relationship between customer segment and preferred product category?

The data analyst aimed to determine the relation ship between the `Segment` and `Catagory`. The analyst used the following query:
```
-- 6. Is there a relationship between customer segment and preferred product category?
SELECT
	Segment,
	Category,
	COUNT(*) AS count
FROM market_sales
GROUP BY Segment, Category
ORDER BY Segment, count DESC;
```
The query determines the frequency of of the products ordered by the `Segment` under their preferred `Category`. The results are:

| Segment | Category | count |
| :--- | :--- | :--- |
| Consumer | Office Supplies | 3072 |
| Consumer | Furniture | 1093 |
| Consumer | Technology | 936 |
| Corporate | Office Supplies | 1783 |
| Corporate | Furniture | 628 |
| Corporate | Technology | 542 |
| Home Office | Office Supplies | 1054 |
| Home Office | Furniture | 357 |
| Home Office | Technology | 335 |

The results show that `Consumer`, `Corporate`, and `Home Office` are more likely to order products under the `Office Supplies` category. Followed by `Furniture` and `Technology`.

There is a relation ship between the `Segment` and `Category` where all of the `Segment` types are more likely to order `Office Supplies` products. The data is visualized with the image below:

![Visual 6](/images/visualizations/visual_market_sales_data_analysis-images-5.jpg)

The results is saved as `6_relationship_segment_category.csv` in the folder `results/data_analysis`.

##### 7. What are the top 10 customers by total sales, and how much do they contribute to overall revenue (Pareto analysis)?

The data analyst seeked to get the top 10 customers with the most sales and compare them to the rest of the total revenue. Using Pareto analysis, the data analyst used the following SQL query:
```
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
    ROUND(cs.total_sales * 100.0 / o.grand_total, 2) AS pct_of_total,
    ROUND(
        SUM(cs.total_sales) OVER (ORDER BY cs.total_sales DESC) * 100.0 / o.grand_total,
        2
    ) AS cumulative_pct
FROM customer_sales cs
CROSS JOIN overall o
ORDER BY cs.total_sales DESC;
```

The query is divided into many steps. Firstly, the query gathers all the customers and their total sum of sales. Secondly, the grand total of all the sales are stored as the `grand_total`. Next, query gathers the `CustomerID`, `CustomerName`, their `total_sales`, the percentage of their sales compared to the `grand_total`, and the cumulative percentages. The top 10 results of the query are:

| CustomerID | CustomerName | total_sales | customer_rank | pct_of_total | cumulative_pct |
| :--- | :--- | :--- | :--- | :--- | :--- |
| SM-20320 | Sean Miller | 25043.0500 | 1 | 1.11 | 1.11 |
| TC-20980 | Tamara Chand | 19052.2180 | 2 | 0.84 | 1.95 |
| RB-19360 | Raymond Buch | 15117.3390 | 3 | 0.67 | 2.62 |
| TA-21385 | Tom Ashbrook | 14595.6200 | 4 | 0.65 | 3.26 |
| AB-10105 | Adrian Barton | 14473.5710 | 5 | 0.64 | 3.90 |
| KL-16645 | Ken Lonsdale | 14175.2290 | 6 | 0.63 | 4.53 |
| SC-20095 | Sanjit Chand | 14142.3340 | 7 | 0.63 | 5.16 |
| HL-15040 | Hunter Lopez | 12873.2980 | 8 | 0.57 | 5.72 |
| SE-20110 | Sanjit Engle | 12209.4380 | 9 | 0.54 | 6.26 |
| CC-12370 | Christopher Conant | 12129.0720 | 10 | 0.54 | 6.80 |

Overall, the customers in the top 10 order sales contribute up to `6.8%` of the overall revenue. The data visualization below shows the whole Pareto Analysis:

![Visual 7](/images/visualizations/visual_market_sales_data_analysis-images-6.jpg)

The results are saves as `7_top_ten_sales.csv` in the folder `results/data_analysis`.

##### 8. Which shipping mode is most commonly used?

The data analyst answered the question by collecting the count of each records under the specific `ShipMode`. The SQL query used are the following:
```

-- 8. Which shipping mode is most commonly used?
SELECT
	ShipMode,
    COUNT(*) AS count
FROM market_sales
GROUP BY ShipMode
ORDER BY count DESC;
```

The query results are the following:

| ShipMode | count |
| :--- | :--- |
| Standard Class | 5859 |
| Second Class | 1902 |
| First Class | 1501 |
| Same Day | 538 |
****
The results show that the `Standard Class` is the most commonly used, followed by `Second Class`, `First Class`, and `Same Day` respectively. The visualization of the data are shown below:

![Visual 9](/images/visualizations/visual_market_sales_data_analysis-images-7.jpg)

The results of the following are saved as `8_ship_mode_count.csv` in the folder `results/data_analysis`.

##### 9. Can you build a time-series model to forecast next quarter's sales?  

The analyst used PoweBI's Forecast functions to build a time-series model that can predict the next quarter's sales. The time-series model with forecast uses 1 forecast length of the units 'Quarters', meaning each length will generate a forecast of one quarter. It uses 90 daily points for the forecast representing the possible days in a quarter with a confidence interval of 95%. The results are the following:

![Visual 8](/images/visualizations/visual_market_sales_data_analysis-images-8.jpg)

The image is divided with lines signifying the end of each first quarter. The forecast predicts the spike in sales just after the start of the year and its decrease after. The forecast also shows the rise and fall of average prices until just after the middle period of the first quarter before the eventual spike just before the and of the quarter. The height of the spikes reflect to the inconsistency of the average sales around the same period.

##### 10. Can you provide a forecast for the next year?

The analyst used PoweBI's Forecast functions to build a time-series model that can forecast the sales up to next year of 2019. The time-series model with forecast uses 1 forecast length of the units 'Years', meaning each length will generate a forecast of one year. It uses 360 daily points for the forecast representing the possible days in a quarter with a confidence interval of 95%. The results are the following:

![Visual 10](/images/visualizations/visual_market_sales_data_analysis-images-9.jpg)

The forecast reflects the spikes in average sales at the start of each year but with varying values. The forecast shows the up and downs of the average sales between January and July. The forecast also shows the prediction of big spikes just after July but with inconsistent values.