# CREDIT RISK DATASET ANALYSIS
###### From the dataset provided by Rohit Sahoo from [Kaggle](https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting).

### Skills

* Data Cleaning, Data Engineering, Data Analysis, Data Visualization and Forecasting
* SQL, MySQL, MySQL Workbench
* PowerBI

### INTRODUCTION

In this project, the analyst used the SQL query language with MySQL to analyze the dataset for market sales and forecasting. The purpose of this analysis is to examine findings and patterns relevant to the topic like seasonal changes, differences of averages in a specific category or type, or for forecasting data. After the analysis, recommendations or suggestions can be provided to help improve business processes or improve sales. In this analysis, the analyst seeked to answer the following questions:

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

Other than that, a PowerBI Dashboard was also made to serve as an interactive way for clients to analyze and examine the results of the data analysis.

### METHODOLOGY

The data analyst conducted the dataset examination using SQL in MySQL Workbench and markdown in VSCode for documentation. The dataset was procured from [Kaggle](https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting) by the provider Rohit Sahoo. The markdown files serves as the documentation for processes done in the project.

#### Project Structure

* .root/
  * cleaned_data/
    * cleaned_market_sales.sql -- The cleaned sql dump file
  * documentation/
    * 1_data_cleaning.md -- The documentation for data cleaning and exploration
    * 2_analysis.md -- The documentation for the data analysis
  * images/
    * visualizations/
      * *data_visualizations.jpg -- images that shows the visualization of results for the questions
    * visual_market_sales_data_analysis.pdf -- compiled pdf file for the images
  * raw_data
    * market_sales.csv -- raw csv file
  * results/
    * *column_id/
      * results.csv -- shows the results of the query from data cleaning
  * sql_queries
    * 1_data_cleaning_queries.sql -- shows the SQL queries used for cleaning and exploring the dataset
    * 2_analysis_queries.sql -- shows the SQL queries used for analyzing the dataset
  * README.md
  * market_sales_data_analysis.pbix -- contains the raw visualizations and the interactive PowerBI Dashboard


#### Installation
 The project can be cloned using the git:
  ```
  git clone https://github.com/Lastlight10/credit_load_risk_data_analysis.git
  ```

  The following notebooks need to run in the following order:  
  1. 1_data_cleaning.md
  2. 2_data_analysis.md

  To run a local version of the dashboard and data visualizations, you can import the file `market_sales_data_analysis.pbix` in your PowerBI:

### CONCLUSION

The data cleaning revealed that the importation of the CSV files as SQL relational tables has caused an issue where blank values are not considered null but as blank strings. It is the only issue found during the data cleaning and analysis. The data analysis consisted of specific SQL queries relevant in finding out the answer to the given questions. The questions and their answers are presented below:

1. Which product category and sub-category generate the highest sales?

![Visual 1](/images/visualizations/visual_market_sales_data_analysis-images-0.jpg)

The visualization of the results show that `Technology, Phones` have the highest total sales followed closely by `Furniture, Chairs`.

2. Which regions are underperforming and might benefit from targeted marketing?

![Visual 2](/images/visualizations/visual_market_sales_data_analysis-images-1.jpg)

The results show that the `Central` region has the lowest amount of average sales, thus is the most underperforming and would benefit a lot from marketing campaigns.

3. What is the distribution of orders across different customer segments (Consumer, Corporate, Home Office)?

![Visual 3](/images/visualizations/visual_market_sales_data_analysis-images-2.jpg)

The data reveals that most of the customers belong in the `Consumer` segment with `52.05%` of the distribution.

4. What is the average order value, and how does it vary by category?

![Visual 4](/images/visualizations/visual_market_sales_data_analysis-images-3.jpg)

The results show a huge variation in the average sales per category with `Technology` being the highest, followed by `Furniture` and lastly `Office Supplies`.

5. What is the average time between order date and ship date, and does it vary by ship mode or region?

![Visual 5](/images/visualizations/visual_market_sales_data_analysis-images-4.jpg)

The results show that in overall, an order takes `3.9611` days to ship. If categorizing by shippind modes, the results show the average length of time between the different shipping modes. `Standard Class` has the longest time with `5.0084` days, followed by `Second Class` with `3.2492` days, `First Class` with `2.1792` days and `Same Day` with `0.0446` days. If categorized by region, The results of the query shows that `Central` has the longest time with `4.0659` days. Followed by `South` with `3.9612` days, `West` with `3.9303` days and lastly, `East` with `3.9102` days. 

6. Is there a relationship between customer segment and preferred product category?

![Visual 6](/images/visualizations/visual_market_sales_data_analysis-images-5.jpg)

The results show that most of the customers are inclined to order products under the category of `Office Supplies`. This means there is a relationship between the customer segments where each type is more likely to order `Office Supplies` products.

7. What are the top 10 customers by total sales, and how much do they contribute to overall revenue (Pareto analysis)?

![Visual 7](/images/visualizations/visual_market_sales_data_analysis-images-6.jpg)

Overall, the top 10 customer contribute up to `6.8%` of the orders. The top 10 customers are listed bellow:

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

8. Which shipping mode is most commonly used?

![Visual 9](/images/visualizations/visual_market_sales_data_analysis-images-7.jpg)

Based on the results, the `Standard Class` is the most popular shipping mode used among the customers.

9.  Can you build a time-series model to forecast next quarter's sales?

The graph below shows the time-series model for the next quarter's forecast:

![Visual 8](/images/visualizations/visual_market_sales_data_analysis-images-8.jpg)

10. Can you provide a forecast for the next year?

The linechart below shows the forecast for the next year:

![Visual 10](/images/visualizations/visual_market_sales_data_analysis-images-9.jpg)

To learn more about the results, the file `2_data_analysis.md` explains the reasons and conclusions made to get the following results.