/*
 ===============================================================================
 Query Purpose: Calculate monthly order volume, total revenue, and average 
 order value (AOV) for completed transactions.
 Dataset:       bigquery-public-data.thelook_ecommerce
 ===============================================================================
 */
SELECT -- 1. Time grouping
    DATE_TRUNC(DATE(o.created_at), MONTH) AS order_month,
    -- 2. Volume metrics
    COUNT(DISTINCT o.order_id) AS total_orders,
    -- 3. Financial metrics
    ROUND(SUM(oid.sale_price), 2) AS total_revenue,
    ROUND(
        SUM(oid.sale_price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM `bigquery-public-data.thelook_ecommerce.orders` o
    JOIN `bigquery-public-data.thelook_ecommerce.order_items` oid ON o.order_id = oid.order_id
GROUP BY 1
ORDER BY 1;
--Result
-- month	orders	revenue	aov
-- 2019-01-01	3	329.97	109.99
-- 2019-02-01	7	528.78	75.54
-- 2019-03-01	7	739.59	105.66
-- 2019-04-01	13	1670.17	128.47
-- 2019-05-01	21	1906.47	90.78
--2019-06-01	19	1620.08	85.27
--2019-07-01	29	2185.69	75.37
--2019-08-01	31	3484.03	112.39
--2019-09-01	29	2693.27	92.87
--2019-10-01	38	3214.99	84.61
--2019-11-01	44	3771.12	85.71
--2019-12-01	47	3302.93	70.28
-- Top 10 revenue across complete order
SELECT p.name as product_name,
    p.category,
    p.brand,
    COUNT(oi.id) as units_sold,
    ROUND(SUM(oi.sale_price), 2) as total_revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
    JOIN `bigquery-public-data.thelook_ecommerce.products` p ON oi.product_id = p.id
WHERE oi.status = 'Complete'
GROUP BY p.name,
    p.category,
    p.brand
ORDER BY total_revenue DESC
LIMIT 10