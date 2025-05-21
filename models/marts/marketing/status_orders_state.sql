WITH orders_with_address AS (
    SELECT
          o.order_id
        , o.status_id
        , a.state
    FROM {{ ref('fct_orders') }} o
    JOIN {{ ref('dim_addresses') }} a
    ON o.address_id = a.address_id
),

orders_with_status AS (
    SELECT
          owa.state
        , s.status
    FROM orders_with_address owa
    JOIN {{ ref('dim_order_status') }} s
    ON owa.status_id = s.status_id
)

SELECT
      state
    , status AS order_status
    , COUNT(*) AS total_orders
FROM orders_with_status
GROUP BY state, status
ORDER BY state, total_orders DESC