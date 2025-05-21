WITH fct_orders AS (
    SELECT
          order_id
        , created_at
        , CASE
              WHEN EXTRACT(HOUR FROM created_at) BETWEEN 0 AND 5 THEN 'Madrugada'
              WHEN EXTRACT(HOUR FROM created_at) BETWEEN 6 AND 11 THEN 'Mañana'
              WHEN EXTRACT(HOUR FROM created_at) BETWEEN 12 AND 17 THEN 'Tarde'
              WHEN EXTRACT(HOUR FROM created_at) BETWEEN 18 AND 23 THEN 'Noche'
          END AS time_range
    FROM {{ ref('fct_orders') }}
    ),

orders_grouped AS (
    SELECT
          time_range
        , COUNT(order_id) AS total_orders
    FROM fct_orders
    GROUP BY time_range
    )

SELECT * FROM orders_grouped