/*
 ===============================================================================
 Query Purpose: New vs Returning Customer Split (Cohort Analysis)
 Dataset:       bigquery-public-data.thelook_ecommerce
 ===============================================================================
 */
WITH user_orders AS (
    SELECT 
        user_id,
        MIN(created_at) AS first_purchase_date,
        COUNT(order_id) AS total_orders
    FROM 
        `bigquery-public-data.thelook_ecommerce.orders`
    WHERE 
        status = 'Complete'
    GROUP BY 
        1
)
SELECT 
    CASE 
        WHEN total_orders = 1 THEN 'New Customer (1 Order)'
        ELSE 'Returning Customer (2+ Orders)' 
    END AS customer_type,
    COUNT(user_id) AS total_customers,
    ROUND(COUNT(user_id) / SUM(COUNT(user_id)) OVER() * 100, 2) AS percent_of_customer_base
FROM 
    user_orders
GROUP BY 
    1
ORDER BY 
    total_customers DESC;
