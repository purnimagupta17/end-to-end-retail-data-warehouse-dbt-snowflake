SELECT
    CUSTOMERID,
    MIN(order_date) AS first_purchase_date,
    MAX(order_date) AS last_purchase_date,
    COUNT(DISTINCT INVOICENO) AS total_orders,
    SUM(total_amount) AS lifetime_value
FROM {{ ref('stg_orders') }}
GROUP BY CUSTOMERID