/*
 ===============================================================================
 Query Purpose: User Behavior & Conversion Funnel Analysis
 Dataset:       bigquery-public-data.thelook_ecommerce
 ===============================================================================
 */
SELECT event_type,
    COUNT(DISTINCT user_id) AS unique_users
FROM `bigquery-public-data.thelook_ecommerce.events`
WHERE event_type IN ('home', 'cart', 'purchase')
GROUP BY event_type
ORDER BY CASE
        event_type
        WHEN 'home' THEN 1
        WHEN 'cart' THEN 2
        WHEN 'purchase' THEN 3
    END;
--result:-
--event_type	users
--home	63206
--cart  80151
--purchase	80151
