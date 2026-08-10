# CREDIT RISK DATASET ANALYSIS
###### From the dataset provided by Rohit Sahoo from [Kaggle](https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting).

### Skills

* Data Cleaning, Data Engineering, Data Analysis, Data Visualization and Forecasting
* SQL, MySQL, MySQL Workbench
* PowerBI

### INTRODUCTION

In this project, the analyst used the SQL query language with MySQL to analyze the dataset for market sales and forecasting. The purpose of this analysis is to examine findings and patterns relevant to the topic like seasonal changes, differences of averages in a specific category or type, or for forecasting data. After the analysis, recommendations or suggestions can be provided to help improve business processes or improve sales. In this analysis, the analyst seeked to answer the following questions:

In this Jupyter notebook, the analyst used the Python programming language to analyze the following dataset about the credit risk of borrowers involved, with the intention to examine and analyze trends, findings, and what recommendations can be given based on the results. The main goal of this analysis is to examine the dataset, identify patterns and provide insights regarding the results. In this way, an analyst can then provide recommendations or suggestions that can help improve businesses. In this analysis, the questions the analyst are seeking to answer are:

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

  To run a local version of the dashboard, you can import the file `market_sales_data_analysis.pbix` in your PowerBI:

### CONCLUSION

After the cleaning and analysis, the results showed columns with missing data and incorrect inputs that are handled using data cleaning and engineering. The data analysis was done using Pandas, Matplotlib, and Seaborn which shows clear representation and analysis done to the columns. The following questions were also answered and their explanation are fleshed out inside the notebook.

1. What is the overall default rate in our dataset?
  
*Ho*: The default rate is greater than or equal to `20%`.  
*Ha*: The default rate is less than `20%`.  
*Conclusion*: The default rate is `17.63%` which makes the alternative hypothesis favorable and reject the null hypothesis.  

2. How does the DTI (Debt to Income) ratio correlate with the likelihood of defaulted loans?    

*Ho*: There is no relationship between the DTI and the likelihood of defaulting.  
*Ha*: There is a relationship between the DTI and the likelihood of defaulting.  
*Conclusion*: The graph shows the rise of the curve as the DTI increases supports that the alternative hypothesis is favorable while the null hypothesis is rejected.

3. What would an average borrower profile look like?  

*Conclusion*: The average borrowers would be around 26 years old, inside the most frequent age brackets of 18-25 and 26-40. They would have an income of 55,000. They are either renting or paying mortgage for their homes. They are employed for 4 years and their purpose for loaning is quite varied and shows no single dominant intent, therefore the purpose does not have a definite answer. Their loan grade would either be A or B. They would loan $8000 with an interest rate of 10.99%. Their loans are mostly paid off with their DTI ratio being 15%. They have a credit history of 4 years.


4. Does the average income change per age group?  

*Ho*: The average income for each age group does not vary.  
*Ha*: The average income increases the higher the age group.  
*Conclusion*: The null hypothesis can be rejected while the alternative hypothesis can be partially supported as the average income did increase but only up to a certain age group.

5. Do borrowers with longer credit history borrow more money?  

*Ho*: The credit history does not affect the amount of money loaned.  
*Ha*: The credit history does affect the amount of money loaned.  
*Conclusion*: Based on the Pearson's r and line chart, there is not enough evidence to support the alternative hypothesis, therefore the null hypothesis is not rejected.

The dashboard can be accessed using the following link:

[Credit Risk Analysis Dashboard](https://creditloadriskdataanalysis-6mj6zzvrhwhxeecuhrm8gt.streamlit.app/)

![Dashboard Image](image.png)

To conclude, the Credit Risk Dataset Analysis was successful in answering questions and providing insights regarding the dataset.