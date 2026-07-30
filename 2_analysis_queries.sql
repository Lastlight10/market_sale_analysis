-- RowID Analysis

-- OrderID Analysis
-- Create CTE where of OrderIDs with more than one value in the dataset
WITH duplicate_rows AS (
	SELECT `OrderID`, COUNT(*) AS no_duplicates
    FROM market_sales
    GROUP BY `OrderID`
    HAVING COUNT(*) > 1
)

SELECT *
FROM duplicate_rows LIMIT 5; 

SELECT `OrderID`
FROM market_sales
WHERE `OrderID` ="CA-2015-100916";