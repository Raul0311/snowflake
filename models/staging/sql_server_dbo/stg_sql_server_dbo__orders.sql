WITH src_orders AS (
    SELECT order_id, shipping_service, shipping_cost, address_id, created_at, promo_id, estimated_delivery_at, 
    order_cost, user_id, order_total, delivered_at, tracking_id, status, date_deleted, _fivetran_synced
    FROM {{ ref('base_sql_server_dbo__orders') }}
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
        , md5(status) AS status_id
        , date_deleted
        , _fivetran_synced
    FROM src_orders
    )

SELECT * FROM renamed_casted