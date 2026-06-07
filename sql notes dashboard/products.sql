/*
 ===============================================================================
 Query Purpose: Revenue + profit by product category
 Dataset:       bigquery-public-data.thelook_ecommerce
 ===============================================================================
 */
WITH sales AS (
    SELECT p.category,
        p.brand,
        ROUND(SUM(oi.sale_price), 2) AS revenue,
        ROUND(SUM(oi.sale_price - p.cost), 2) AS profit
    FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
        JOIN `bigquery-public-data.thelook_ecommerce.products` p ON oi.product_id = p.id
    WHERE oi.status = 'Complete'
    GROUP BY 1,
        2
)
SELECT *,
    RANK() OVER(
        PARTITION BY category
        ORDER BY revenue DESC
    ) AS rank_in_cat
FROM sales;

/*
 ===============================================================================
 Query Purpose: Top 5 Product category by total profit,total revenue and avg retail_price
 Dataset:       bigquery-public-data.thelook_ecommerce
 ===============================================================================
 */
WITH sales AS (
    SELECT p.category,
        ROUND(SUM(oi.sale_price), 2) AS revenue,
        ROUND(AVG(p.retail_price), 2) AS avg_retail_price,
        ROUND(SUM(oi.sale_price - p.cost), 2) AS profit
    FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
        JOIN `bigquery-public-data.thelook_ecommerce.products` p ON oi.product_id = p.id
    WHERE oi.status = 'Complete'
    GROUP BY 1
)
SELECT *
FROM sales
ORDER BY revenue DESC
LIMIT 5;