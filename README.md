# Olist E-commerce SQL Analysis

## Project Overview

This project analyzes the Olist e-commerce dataset using MySQL to understand order activity, product sales trends, top-performing product categories and sellers, and customer review scores.

The goal is to turn raw e-commerce records into clear business metrics and practical observations using SQL.

## Tools Used

- **MySQL** — querying and aggregating the data
- **MySQL Workbench** — database management and query execution
- **SQL** — joins, grouping, aggregate functions, date formatting, filtering, and window functions

## Business Questions

1. What do the overall order-item and sales metrics look like?
2. How did delivered-order product sales change month by month?
3. Which product categories generated the highest product sales?
4. Which sellers generated the highest product sales?
5. What does the customer review-score distribution look like?

## Key Findings

- **Overall order-item metrics:** 112,650 item rows, 98,666 distinct orders represented in `order_items`, 32,951 distinct products, and 3,095 distinct sellers.
- **Product value and freight:** Total item `price` was **13,591,643.70** and total `freight_value` was **2,251,909.54** across the `order_items` table. These are recorded item values, not profit.
- **Monthly sales:** November 2017 had the highest monthly product sales in the delivered-order analysis, at **987,765.37**, across **7,289 delivered orders**.
- **Top product category:** `health_beauty` led the category analysis with product sales of **1,233,131.72**.
- **Top seller by product sales:** Seller `4869f7a5dfa277a7dca6462dcf3b52b2` led the seller analysis with product sales of **226,987.93**.
- **Customer reviews:** 57.78% of reviews were 5-star and 77.07% were 4- or 5-star. The weighted average review score is approximately **4.09 out of 5**.

> **Metric note:** The sales figures in this project are based on the `price` field from order items. They should not be interpreted as profit. Monthly, category, and seller analyses filter to orders marked `delivered`; the overall item metrics do not use that same status filter.

## SQL Concepts Demonstrated

- `COUNT()` and `COUNT(DISTINCT ...)`
- `SUM()` and `ROUND()`
- `JOIN` and `LEFT JOIN`
- `GROUP BY` and `ORDER BY`
- `DATE_FORMAT()` for monthly aggregation
- `COALESCE()` for category labels
- Window functions for review percentages
- Primary keys and foreign-key relationships in the database schema

## Files

- `olist_ecommerce_business_analysis.sql` — organized SQL queries for the business analyses
- `README.md` — project overview, business questions, and key findings

## How to Run

1. Create or select the `Olist_Ecommerce_DB` database in MySQL Workbench.
2. Import the dataset tables and confirm that the tables required by the analysis exist.
3. Open `olist_ecommerce_business_analysis.sql` in MySQL Workbench.
4. Select the `Olist_Ecommerce_DB` schema and execute the queries.
5. Compare the outputs with the findings above. Small differences can occur if the underlying data or filters have changed.

## Conclusion

This project demonstrates how SQL can be used to examine e-commerce sales patterns, compare category and seller performance, and summarize customer ratings. The results provide a starting point for further business questions, such as delivery performance, payment behavior, and low-review order patterns.
