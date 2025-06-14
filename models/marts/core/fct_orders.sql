{{
    config(
        materialized='incremental'
    )
}}

WITH stg_orders AS (
    SELECT order_id, shipping_service, shipping_cost, address_id, created_at, promo_id, 
    estimated_delivery_at, order_cost, user_id, delivered_at, tracking_id, status_id
    FROM {{ ref('stg_sql_server_dbo__orders') }}
    ),

stg_order_items AS (
    SELECT order_id, product_id, quantity,
    FROM {{ ref('stg_sql_server_dbo__order_items') }}
    ),

-- Total de unidades en cada pedido
total_units_per_order AS (
    SELECT 
          order_id
        , SUM(quantity) AS total_units
    FROM stg_order_items
    GROUP BY order_id
),

renamed_casted AS (
    SELECT
          orders.order_id
        , orders.shipping_service
        , ROUND(orders.shipping_cost / NULLIF(tl_units.total_units, 0), 2) AS product_shipping_cost
        , orders.address_id
        , CAST(md5(CONCAT(orders.order_id, '|', orders.created_at)) AS VARCHAR(80)) AS delivered_id
        , orders.promo_id
        , orders.order_cost / quantity AS product_cost
        , orders.user_id
        , orders.tracking_id
        , orders.status_id
        , order_it.product_id
        , order_it.quantity
    FROM stg_orders orders
    JOIN stg_order_items order_it
    ON orders.order_id = order_it.order_id
    JOIN total_units_per_order tl_units
    ON order_it.order_id = tl_units.order_id
    )

SELECT * FROM renamed_casted