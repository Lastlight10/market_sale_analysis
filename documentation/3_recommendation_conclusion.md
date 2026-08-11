# Market Sales Dataset Analysis

##### Dataset provided by [Rohit Sahoo](https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting) from Kaggle.

## Insights and Recommendations

#### Early Yearly Sale Spike

The analysis of the data presented a recurring trend where for every start of the year around late January to early February after 2015, a very noticeable spike in sales is present. Typically, this early spike can result from new year fiscal budgets by companies looking to expand or replace products which causes the spike. The data analyst recommends the company the following points:

  * Early Yearly Marketing Campaign
    * The evidence of high sales during the period suggests a trend of a spike in sales. Marketing campaigns can be used to further promote the growth of the sales and capitalize the trend. This can be done through promos, special deals or extensive ad campaigns.

#### Office Supplies: Highest Volumes but Lowest Average Sales

The analysis showed that the products under the category of `Office Supplies` have the most amount of orders in terms on number of products but the lowest in average sales. This could mean that most products under that category are cheap but bought by bulk. The analyst recommend the following points to increase the sales of bulk products:

  * Special Bulk Order Promos and Marketing Campaigns
    * Improving the time between the shipping dates and order dates can help promote the capabilities of the company. The said company can provide discounts or promos for consumers who purchase in bulk. Some of these can include discounts for faster shipping modes, special bulk order promos during the early first quarter period, or setup special deals and contracts before the start of the new year especially for corporate customers.

#### South Region: Least Orders but Highest Average in Sales

The `South` region has the lowest amount of orders but the biggest in sales. This can be because of several reasons such as their priority to buy products in lower volumes but higher prices per unit. The result of these sale are dependent on the needs of the companies but to analyze further, the analyst used SQL queries and the results are the following:

| SubCategory | average_sales | total_sales | count_orders |
| :--- | :--- | :--- | :--- |
| Machines | 2993.94222222 | 53890.9600 | 18 |
| Copiers | 1328.53657143 | 9299.7560 | 7 |
| Tables | 876.60424000 | 43830.2120 | 50 |
| Chairs | 520.22379070 | 44739.2460 | 86 |
| Phones | 417.97365468 | 58098.3380 | 139 |
| Bookcases | 389.26292857 | 10899.3620 | 28 |
| Supplies | 286.85958621 | 8318.9280 | 29 |  
| Storage | 277.56771654 | 35251.1000 | 127 |
| Appliances | 241.05340741 | 19525.3260 | 81 |
| Accessories | 215.24923200 | 26906.1540 | 125 |
| Binders | 152.42475104 | 36734.3650 | 241 |
| Furnishings | 105.32506173 | 17062.6600 | 162 |
| Paper | 63.72282569 | 13891.5760 | 218 |
| Envelopes | 61.95474074 | 3345.5560 | 54 |
| Labels | 36.62781250 | 2344.1800 | 64 |
| Art | 32.21731429 | 4510.4240 | 140 |
| Fasteners | 17.35572414 | 503.3160 | 29 |

From the SQL query:
```
SELECT
 SubCategory,
 AVG(Sales) AS average_sales,
 SUM(Sales) AS total_sales,
 COUNT(*) AS count_orders
FROM market_sales
WHERE Region = 'South'
GROUP BY SubCategory
ORDER BY average_sales DESC;
```

Based on the results, the region mostly bought machines for office use specifically `Machines` and `Copiers`. These products are expensive per unit and only bought in low quantity compared to the other products. Based on these results, the data analyst recommends the following:

  * Special Marketing and Promos for Products Under`Machines and Copiers
    * This region shows a trend where machines are the most profitable products. Marketing campaigns, special offers for ordering in bulk, as well as seasonal discounts can help in improving the sales of said products. 
  * Product Analysis and Variety
    * Since products under the categories of `Machines` and `Copiers` can vary, analyzing which products are sold in these categories can provide a clearer understanding of the situation. In this way, the company can decide whether to invest in this product or branch out to more variety.

#### Consumers: Majority of Customers

The data revealed that majority of the customers are under the `Consumer` segment meaning most of the company's customers are the regular citizens not corporations or institution. Knowing your main customer can be very beneficial therefore, the data analyst provided the following suggestions:

  * Consumer Dedicated Marketing
    * Promoting seasonal deals, ad campaigns, or special offers dedicated to customers under `Consumer` segment can promote their growth in sales and encourage new and old customers to purchase from the company.
  
  * Expanded Customer Marketing
    * Since there are customers under the other segments, it is also beneficial for the company to branch out their customers for `Corporate` and `Home Office`. This way, the company can effectively rely on multiple types of customers, making the source of income varied across segments.

## Conclusion

