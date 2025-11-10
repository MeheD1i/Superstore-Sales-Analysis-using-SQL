## Project Overview

This project focuses on performing business analysis using SQL on the Sample Superstore dataset.  
The goal is to uncover **key business insights** related to sales, profit, customers and discount strategies.

---

##  Dataset Information

- **Dataset Name:** Sample Superstore  
- **Total Rows:** 9,694  
- **File Type:** CSV  
- **Source:** Kaggle

---

### Key Columns:
| Column | Description |
|---------|--------------|
| Order_ID | Unique identifier for each order |
| Order_Date | Date when the order was placed |
| Product_Name | Name of all products |
| Customer_Name | Name of the customer |
| Segment | Customer segment (Consumer, Corporate, Home Office) |
| Country / Region / State / City | Location details |
| Category / Sub-Category | Product type |
| Sales | Total revenue from the order |
| Profit | Profit earned from the order |
| Discount | Discount applied on the sale |

---

## Database Setup
-- Create and select the database
CREATE DATABASE IF NOT EXISTS superstore;
USE superstore;

-- Import the CSV data into a table named 'orders'

---

### 1. Sales and Profit Performance by Region and Category

**Business Question:**  
> Which regions and product categories generate the highest sales and profit?  
> Which areas show low profitability?

---

#### SQL Query:
```sql
SELECT 
    Region,
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Avg_Profit_Margin
FROM orders
GROUP BY Region, Category
ORDER BY Total_Profit DESC;
```
-Output-
| Region  | Category        | Total_Sales | Total_Profit | Avg_Profit_Margin (%) |
| :------ | :-------------- | ----------: | -----------: | --------------------: |
| West    | Office Supplies |  213,125.18 |    51,161.45 |                 24.01 |
| East    | Technology      |  264,872.08 |    47,439.56 |                 17.91 |
| West    | Technology      |  251,895.93 |    44,271.28 |                 17.58 |
| East    | Office Supplies |  201,781.62 |    40,730.64 |                 20.19 |
| Central | Technology      |  170,401.53 |    33,693.44 |                 19.77 |
| South   | Technology      |  148,730.52 |    19,982.82 |                 13.44 |
| South   | Office Supplies |  123,979.92 |    19,577.08 |                 15.79 |
| West    | Furniture       |  248,450.23 |    10,588.42 |                  4.26 |
| Central | Office Supplies |  164,616.20 |     9,020.72 |                  5.48 |
| South   | Furniture       |  116,273.14 |     6,475.79 |                  5.57 |
| East    | Furniture       |  205,540.35 |     2,501.82 |                  1.22 |
| Central | Furniture       |  162,783.14 |    -2,585.25 |                 -1.59 |

#### Opinion:
West - Office Supplies gives the highest profit (51,161.45) and excellent margin of (24%).
Furniture has very low margins (1–5%), and in Central region the profit is negative (-1.59%).

---

### 2. Monthly Sales & Profit Trend

**Business Question:**  
> How do sales and profit change over time?  
> Which months perform best?

---

#### SQL Query:
```sql
-- Check date format
SELECT Order_Date FROM orders LIMIT 5;

-- Monthly Sales & Profit Trend
SELECT 
    DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%Y-%m') AS YearMonth, 
    ROUND(SUM(Sales), 2) AS Monthly_Sales,
    ROUND(SUM(Profit), 2) AS Monthly_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100,2) AS Avg_Profit_Margin
FROM orders
GROUP BY YearMonth
ORDER BY Monthly_Profit DESC;
```
-Output-
| Year-Month | Monthly_Sales | Monthly_Profit | Avg_Profit_Margin (%) |
| :--------- | ------------: | -------------: | --------------------: |
| 2016-12    |     96,075.07 |      17,547.22 |                 18.26 |
| 2016-10    |     58,120.42 |      16,190.55 |                 27.86 |
| 2017-03    |     58,739.22 |      14,721.66 |                 25.06 |
| 2015-11    |     74,699.03 |      12,573.02 |                 16.83 |
| 2017-09    |     86,487.31 |      10,722.30 |                 12.40 |
| 2015-03    |     38,621.29 |       9,683.86 |                 25.07 |
| 2017-11    |    117,383.38 |       9,502.79 |                  8.10 |
| 2017-10    |     77,542.48 |       9,239.98 |                 11.92 |
| 2014-11    |     78,297.24 |       9,181.78 |                 11.73 |
| 2016-09    |     71,848.25 |       9,006.62 |                 12.54 |

#### Opinion:
December 2016 and October 2016 were the most profitable months. Late-year months (Oct–Dec) consistently show strong sales.

---

### 3. Top Product Performance Analysis

**Business Question:**  
> Which products generate the highest profits?  

---

#### SQL Query:
```sql
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

```
-Output- 
| Product_Name                                                                | Total_Sales | Total_Profit |
| :-------------------------------------------------------------------------- | ----------: | -----------: |
| Canon imageCLASS 2200 Advanced Copier                                       |   61,599.82 |    25,199.93 |
| Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind |   27,453.38 |     7,753.04 |
| Hewlett Packard LaserJet 3310 Copier                                        |   18,839.69 |     6,983.88 |
| Canon PC1060 Personal Laser Copier                                          |   11,619.83 |     4,570.93 |
| HP Designjet T520 Inkjet Large Format Printer - 24" Color                   |   18,374.90 |     4,094.98 |
| Ativa V4110MDD Micro-Cut Shredder                                           |    7,699.89 |     3,772.95 |
| 3D Systems Cube Printer, 2nd Generation, Magenta                            |   14,299.89 |     3,717.97 |
| Plantronics Savi W720 Multi-Device Wireless Headset System                  |    9,367.29 |     3,696.28 |
| Ibico EPK-21 Electric Binding System                                        |   15,875.92 |     3,345.28 |
| Zebra ZM400 Thermal Label Printer                                           |    6,965.70 |     3,343.54 |

#### Opinion:
Canon imageCLASS 2200 Advanced Copier is the most profitable product. It contributes over $25K in total profit, which is significantly ahead of others.

---

### 4. Products Losing Money (Negative Profit)

**Business Question:**  
> Which products are generating losses for the company?  

---

#### SQL Query:
```sql
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
```

-Output- 
| Product_Name                                                      | Total_Sales | Total_Profit |
| :---------------------------------------------------------------- | ----------: | -----------: |
| Cubify CubeX 3D Printer Double Head Print                         |   11,099.96 |    -8,879.97 |
| Lexmark MX611dhe Monochrome Laser Printer                         |   16,829.90 |    -4,589.97 |
| Cubify CubeX 3D Printer Triple Head Print                         |    7,999.98 |    -3,839.99 |
| Chromcraft Bull-Nose Wood Oval Conference Tables & Bases          |    9,917.64 |    -2,876.12 |
| Bush Advantage Collection Racetrack Conference Table              |    9,544.72 |    -1,934.40 |
| GBC DocuBind P400 Electric Binding System                         |   17,965.07 |    -1,878.17 |
| Cisco TelePresence System EX90 Videoconferencing Unit             |   22,638.48 |    -1,811.08 |
| Martin Yale Chadless Opener Electric Letter Opener                |   16,656.20 |    -1,299.18 |
| Balt Solid Wood Round Tables                                      |    6,518.75 |    -1,201.06 |
| BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables |    1,706.25 |    -1,148.44 |

#### Opinion:
Cubify CubeX 3D Printer Double Head Print is showing heavy losses than others.

---

###5. Regional Sales and Profit Analysis

**Business Question:**  
> Which states generate the highest sales?  
> Are there any regions with strong sales but weak profitability?

---

#### SQL Query:
```sql
-- Regional city analysis
SELECT 
    State,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 10;
```
-Output- 
| State        | Total_Sales | Total_Profit |
| :----------- | ----------: | -----------: |
| California   |  450,567.59 |    74,669.20 |
| New York     |  309,453.63 |    73,507.13 |
| Texas        |  169,553.63 |   -25,534.99 |
| Washington   |  136,590.17 |    32,976.62 |
| Pennsylvania |  114,911.24 |   -15,446.38 |
| Florida      |   88,876.88 |    -3,382.71 |
| Illinois     |   79,009.29 |   -12,031.07 |
| Ohio         |   76,617.64 |   -17,071.22 |
| Michigan     |   75,991.58 |    24,340.95 |
| Virginia     |   70,309.09 |    18,461.02 |

#### Opinion:
California and New York are the top-performing states both in sales and profit. Texas and Pennsylvania show high sales but negative profit.

---

### 6. Top 10 Customers by Profit

**Business Question:**  
> Who are the top customers contributing the most to total profit?  
> What percentage of total profit do these top customers account for?

---

#### SQL Query:
```sql
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
```
-Output- 
| Profit_Rank | Customer_Name        | Total_Sales | Total_Profit | Contribution_% |
| :---------: | :------------------- | ----------: | -----------: | -------------: |
|      1      | Tamara Chand         |   19,017.85 |     8,964.48 |           3.17 |
|      2      | Raymond Buch         |   15,117.34 |     6,976.10 |           2.47 |
|      3      | Sanjit Chand         |   14,142.33 |     5,757.41 |           2.04 |
|      4      | Hunter Lopez         |   12,873.30 |     5,622.43 |           1.99 |
|      5      | Adrian Barton        |   14,355.61 |     5,438.91 |           1.92 |
|      6      | Tom Ashbrook         |   14,595.62 |     4,703.79 |           1.66 |
|      7      | Christopher Martinez |    8,954.02 |     3,899.89 |           1.38 |
|      8      | Keith Dawkins        |    8,181.26 |     3,038.63 |           1.07 |
|      9      | Andy Reiter          |    6,608.45 |     2,884.62 |           1.02 |
|      10     | Daniel Raglin        |    8,350.87 |     2,869.08 |           1.01 |

#### Opinion:
Tamara Chand stands out as the most profitable customer, generating over 8.9K in profit (3.17%) alone.

---

### 💸 5. Discount Impact on Profit

**Business Question:**  
> Is there a correlation between discounts and profit?  
> Do higher discounts actually lead to more sales, or do they reduce profitability?

---

#### 💻 SQL Query:
```sql
-- Discount Impact on Profit
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
```

| Discount_Level  |  Total_Sales | Total_Profit | Avg_Profit_Margin (%) |
| :-------------- | -----------: | -----------: | --------------------: |
| No Discount     | 1,072,777.32 |   317,184.04 |                 29.57 |
| Low (1–20%)     |   838,235.31 |    99,827.47 |                 11.91 |
| Medium (41–60%) |    70,640.91 |   -28,547.94 |                -40.41 |
| Medium (21–40%) |   234,065.97 |   -35,825.86 |                -15.31 |
| High (>60%)     |    56,730.34 |   -69,779.97 |               -123.00 |


#### Opinion:
The “No Discount” segment is by far the most profitable about 29.6% margin and over $317K profit.
Even a low discount (1–20%) reduces profit margin significantly to around 12%.
Medium and High discount ranges result in negative profits, meaning products are being sold at a loss.
