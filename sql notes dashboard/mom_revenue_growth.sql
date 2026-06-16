/*
 ===============================================================================
 Query Purpose: Month-over-Month (MoM) Revenue Growth using Window Functions
 Dataset:       bigquery-public-data.thelook_ecommerce
 ===============================================================================
 */
WITH monthly_revenue AS (
    SELECT 
        DATE_TRUNC(DATE(created_at), MONTH) AS order_month,
        ROUND(SUM(sale_price), 2) AS current_revenue
    FROM 
        `bigquery-public-data.thelook_ecommerce.order_items`
    WHERE 
        status = 'Complete'
    GROUP BY 
        1
)
SELECT 
    order_month,
    current_revenue,
    LAG(current_revenue) OVER(ORDER BY order_month) AS previous_month_revenue,
    ROUND(((current_revenue - LAG(current_revenue) OVER(ORDER BY order_month)) / 
        LAG(current_revenue) OVER(ORDER BY order_month)) * 100, 2) AS mom_growth_percent
FROM 
    monthly_revenue
ORDER BY 
    order_month DESC;
