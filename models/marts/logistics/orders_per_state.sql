WITH fct_orders AS (
    SELECT order_id, address_id
    FROM {{ ref('fct_orders') }}
    ),

dim_addresses AS (
    SELECT address_id, state
    FROM {{ ref('dim_addresses') }}
    ),

orders_per_state AS (
    SELECT
          DISTINCT
          md5(CONCAT(o.order_id, '|', a.state)) AS order_state_id
        , o.order_id
        , a.state
    FROM fct_orders o
    JOIN dim_addresses a
    ON o.address_id = a.address_id
    )

SELECT * FROM orders_per_state