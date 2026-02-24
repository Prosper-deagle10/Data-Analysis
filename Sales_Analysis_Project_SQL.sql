-- Sales Performance Analysis Using SQL (Rebuilt from Excel-based Analysis)

# I rebuilt the Excel project in SQL to show that I can:
-- Design a database
-- Load raw business data
-- Clean and transform data using SQL
-- Answering business questions with queries. 

# Designing the database 
CREATE DATABASE `project`;
USE `project`;

# Load raw business data
SELECT * FROM project.sales_data
LIMIT 5;

# Clean and transform data
-- The OrderID column had some special characters at the front of the text.
ALTER TABLE sales_data
CHANGE COLUMN `ï»¿Order ID` order_id VARCHAR(20);

SELECT * FROM project.sales_data;

# Data Validation. First Quality Checks
SELECT COUNT(*) AS total_records
FROM sales_data; -- The total_recors showed 1194

# Check missing values
SELECT 
    SUM(order_id IS NULL) AS missing_order_id,
    SUM(`Order Date` IS NULL) AS missing_order_date,
    SUM(Quantity IS NULL) AS missing_sales,
    SUM(Profit IS NULL) AS missing_profit
FROM project.sales_data;

# BUSINESS FOCUS
-- Total quantity sold
SELECT SUM(Quantity) 
FROM project.sales_data; -- '12,745' gotten

-- Total Amount 
SELECT SUM(Amount) 
FROM project.sales_data; -- '6,182,639' gotten

-- -- Total Profit 
SELECT SUM(Profit) 
FROM project.sales_data; -- '1,610,697' gotten

-- Top profitable Category
SELECT 
   Category,
    ROUND(SUM(Profit), 2) AS total_profit
FROM project.sales_data
GROUP BY Category
ORDER BY total_profit DESC
;

-- Regional performance
SELECT 
    State,
    ROUND(SUM(Amount), 2) AS total_amount,
    ROUND(SUM(Profit), 2) AS total_profit
FROM project.sales_data
GROUP BY State
ORDER BY total_profit DESC;

-- Monthly profit trend
SELECT 
monthname(STR_TO_DATE(`Year-Month`, '%YYYY-%mm-%dd')) AS Monthly_profit,
    ROUND(SUM(Profit), 2) AS total_profit
FROM project.sales_data
GROUP BY  `Year-Month`;

-- PaymentMode performance
SELECT 
    PaymentMode,
    ROUND(SUM(Quantity), 2) AS total_order_quantity,
    ROUND(SUM(Profit), 2) AS total_profit
FROM project.sales_data
GROUP BY PaymentMode
ORDER BY total_profit DESC;