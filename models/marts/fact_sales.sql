{{ config(
    materialized='incremental',
    unique_key='INVOICENO'
    on_schema_change='sync_all_columns'
) }}

SELECT
    INVOICENO,
    STOCKCODE,
    CUSTOMERID,
    order_date,
    QUANTITY,
    UNITPRICE,
    total_amount
FROM {{ ref('stg_orders') }}

{% if is_incremental() %}

-- Only process new records
WHERE order_date > (SELECT MAX(order_date) FROM {{ this }})

{% endif %}