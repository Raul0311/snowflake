WITH orders_with_address AS (
    SELECT
          DISTINCT
          o.order_id
        , o.status_id
        , a.state
        , o.estimated_delivery_at
    FROM {{ ref('fct_orders') }} o
    JOIN {{ ref('dim_addresses') }} a
    ON o.address_id = a.address_id
    ),

orders_with_status AS (
    SELECT
          owa.order_id
        , owa.state
        , s.status
        , owa.estimated_delivery_at
    FROM orders_with_address owa
    JOIN {{ ref('dim_order_status') }} s
    ON owa.status_id = s.status_id
    ),

status_orders_state AS ( 
    SELECT
          state
        , status AS order_status
        , order_id
        , estimated_delivery_at
    FROM orders_with_status
    )

SELECT * FROM status_orders_state