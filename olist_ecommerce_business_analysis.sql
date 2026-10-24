/*
Project: Olist E-commerce SQL Analysis
Database: olist_ecommerce_db
Purpose: Explore order-item value, monthly delivered-order sales,
         product-category performance, seller performance, and reviews.

Prerequisite:
- Import the Olist dataset tables into MySQL first.
- This file contains analysis queries only; it does not create or import tables.
*/

USE olist_ecommerce_db;

/* ============================================================
   1. OVERALL ORDER-ITEM SNAPSHOT
   Note: price and freight totals include all rows in order_items,
   regardless of order status. They are not profit figures.
   ============================================================ */
SELECT
    COUNT(*) AS total_item_rows,
    COUNT(DISTINCT order_id) AS orders_with_items,
    COUNT(DISTINCT product_id) AS unique_products,
    COUNT(DISTINCT seller_id) AS unique_sellers,
    ROUND(SUM(price), 2) AS total_item_price_value,
    ROUND(SUM(freight_value), 2) AS total_freight_value
FROM order_items;

/* ============================================================
   2. MONTHLY SALES PERFORMANCE
   Delivered orders only; sales are summed from item prices.
   ============================================================ */
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    ROUND(SUM(oi.price), 2) AS product_sales,
    ROUND(SUM(oi.freight_value), 2) AS freight_value
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;

/* ============================================================
   3. TOP 10 PRODUCT CATEGORIES BY PRODUCT SALES
   Delivered orders only.
   ============================================================ */
SELECT
    COALESCE(
        t.product_category_name_english,
        p.product_category_name,
        'Unknown'
    ) AS product_category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS product_sales
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation AS t
    ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY product_category
ORDER BY product_sales DESC
LIMIT 10;

/* ============================================================
   4. TOP 10 SELLERS BY PRODUCT SALES
   Delivered orders only. Seller IDs are retained as identifiers.
   ============================================================ */
SELECT
    oi.seller_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS product_sales
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id
ORDER BY product_sales DESC
LIMIT 10;

/* ============================================================
   5. CUSTOMER REVIEW SCORE DISTRIBUTION
   Percentage is calculated across all review rows.
   ============================================================ */
SELECT
    review_score,
    COUNT(*) AS total_reviews,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;

/* ============================================================
   6. AVERAGE CUSTOMER REVIEW SCORE
   ============================================================ */
SELECT
    COUNT(*) AS total_reviews,
    ROUND(AVG(review_score), 2) AS average_review_score,
    ROUND(
        100.0 * SUM(review_score IN (4, 5)) / COUNT(*),
        2
    ) AS positive_reviews_percentage,
    ROUND(
        100.0 * SUM(review_score IN (1, 2)) / COUNT(*),
        2
    ) AS low_reviews_percentage
FROM order_reviews;
