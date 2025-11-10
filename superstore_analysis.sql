-- Create the database
CREATE DATABASE IF NOT EXISTS superstore;
USE superstore;

-- Verify Import
SELECT * 
FROM orders
LIMIT 10;

SELECT COUNT(*) AS Total_rows
FROM orders;  # number of rows = 9694

-- Sales and Profit Performance

SELECT 
    Region,
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Avg_Profit_Margin
FROM orders
GROUP BY Region, Category
ORDER BY Total_Profit DESC;


-- Monthly Sales & Profit Trend
SELECT Order_Date FROM orders LIMIT 5;

SELECT 
    # DATE_FORMAT(Order_Date, '%Y-%m') AS YearMonth,
	DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%Y-%m') AS YearMonth, # as order_date is not in date format thats why i used STR_TO_DATE()
    ROUND(SUM(Sales), 2) AS Monthly_Sales,
    ROUND(SUM(Profit), 2) AS Monthly_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100,2) AS Avg_Profit_Margin
FROM orders
GROUP BY YearMonth
ORDER BY Monthly_Profit DESC;



-- Product Performance
SELECT COUNT(DISTINCT(Product_Name))
FROM orders; #1798

-- TOP 10 products that generate the highest profit
SELECT 
    Product_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY Product_Name
ORDER BY Total_Profit DESC
LIMIT 10;

-- TOP 10 products that are losing money (negative profit)
SELECT 
    Product_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY Product_Name
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC
LIMIT 10;

-- Regional city analysis
SELECT 
    State,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 10;

-- Discount Impact
SELECT DISTINCT(Discount)
FROM orders;

SELECT
    CASE 
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount BETWEEN 0.01 AND 0.2 THEN 'Low (1–20%)'
        WHEN Discount BETWEEN 0.21 AND 0.4 THEN 'Medium (21–40%)'
        WHEN Discount BETWEEN 0.41 AND 0.6 THEN 'Medium (41–60%)'
        WHEN Discount > 0.6 THEN 'High (>60%)'
    END AS Discount_Level,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS AVG_Profit_Margin
FROM orders
GROUP BY Discount_Level
ORDER BY Total_Profit DESC;



-- Top 10 Customers by Profit 
SELECT 
    Customer_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / (SELECT SUM(Profit) FROM orders) * 100, 2) AS Contribution_Percent,
    RANK() OVER (ORDER BY SUM(Profit) DESC) AS Profit_Rank
FROM orders
GROUP BY Customer_Name
ORDER BY Profit_Rank
LIMIT 10;






