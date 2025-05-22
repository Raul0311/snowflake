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
          md5(a.state) AS order_state_id
        , a.state
        , COUNT(o.order_id) AS total_orders
    FROM fct_orders o
    JOIN dim_addresses a
    ON o.address_id = a.address_id
    GROUP BY a.state
    )

SELECT * FROM orders_per_state