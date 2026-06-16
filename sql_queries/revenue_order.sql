/*
 ===============================================================================
 Query Purpose: Calculate monthly order volume, total revenue, and average 
 order value (AOV) for completed transactions.
 Dataset:       bigquery-public-data.thelook_ecommerce
 ===============================================================================
 */
SELECT 
    -- 1. Time grouping
    DATE_TRUNC(DATE(o.created_at), MONTH) AS order_month,
    -- 2. Volume metrics
    COUNT(DISTINCT o.order_id) AS total_orders,
    -- 3. Financial metrics
    ROUND(SUM(oid.sale_price), 2) AS total_revenue,
    ROUND(SUM(oid.sale_price) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
FROM 
    `bigquery-public-data.thelook_ecommerce.orders` o
JOIN 
    `bigquery-public-data.thelook_ecommerce.order_items` oid ON o.order_id = oid.order_id
WHERE 
    o.status = 'Complete'
GROUP BY 
    1
ORDER BY 
    1;

/*
--- Query Scope & Results Note ---
This query tracks monthly order volume, total revenue, and average order value (AOV) across the entire multi-year timeline (2019-2026) using order-level completion status.

Early Launch Phase (2019):
- 2019-02-01: 9 orders, ₹822.91 revenue, ₹91.43 AOV
- 2019-12-01: 60 orders, ₹4,693.13 revenue, ₹78.22 AOV

Mature Scaling Phase (2025-2026):
- 2025-12-01: 938 orders, ₹81,213.19 revenue, ₹86.58 AOV
- 2026-03-01: 1,130 orders, ₹95,500.74 revenue, ₹84.51 AOV
- 2026-05-01: 1,556 orders, ₹129,058.48 revenue, ₹82.94 AOV
*/

/*
 ===============================================================================
 Query Purpose: Top 10 revenue-generating products across completed orders
 Dataset:       bigquery-public-data.thelook_ecommerce
 ===============================================================================
 */
SELECT 
    p.name AS product_name,
    p.category,
    p.brand,
    COUNT(oi.id) AS units_sold,
    ROUND(SUM(oi.sale_price), 2) AS total_revenue
FROM 
    `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN 
    `bigquery-public-data.thelook_ecommerce.products` p ON oi.product_id = p.id
WHERE 
    oi.status = 'Complete'
GROUP BY 
    1, 2, 3
ORDER BY 
    total_revenue DESC
LIMIT 10;