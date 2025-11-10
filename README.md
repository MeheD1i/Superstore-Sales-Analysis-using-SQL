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

### 🧮 1. Sales and Profit Performance by Region and Category

**Business Question:**  
> Which regions and product categories generate the highest sales and profit?  
> Which areas show low profitability?

---

#### 💻 SQL Query:
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

Query Result:
Region	Category	Total_Sales	Total_Profit	Avg_Profit_Margin (%)
West	Office Supplies	213,125.18	51,161.45	24.01
East	Technology	264,872.08	47,439.56	17.91
West	Technology	251,895.93	44,271.28	17.58
East	Office Supplies	201,781.62	40,730.64	20.19
Central	Technology	170,401.53	33,693.44	19.77
South	Technology	148,730.52	19,982.82	13.44
South	Office Supplies	123,979.92	19,577.08	15.79
West	Furniture	248,450.23	10,588.42	4.26
Central	Office Supplies	164,616.20	9,020.72	5.48
South	Furniture	116,273.14	6,475.79	5.57
East	Furniture	205,540.35	2,501.82	1.22
Central	Furniture	162,783.14	-2,585.25	-1.59
