WITH src_orders AS (
    SELECT order_id, shipping_service, shipping_cost, address_id, created_at, promo_id, estimated_delivery_at, 
    order_cost, user_id, order_total, delivered_at, tracking_id, status, _fivetran_deleted
    FROM {{ ref('orders_timestamp_snp') }}
    ),

renamed_casted AS (
    SELECT
          order_id
        , shipping_service
        , shipping_cost
        , address_id
        , created_at
        , promo_id
        , estimated_delivery_at
        , order_cost
        , user_id
        , order_total
        , delivered_at
        , tracking_id
        , dm5('status') AS status
        , date_deleted
    FROM src_orders
    )

SELECT * FROM renamed_casted