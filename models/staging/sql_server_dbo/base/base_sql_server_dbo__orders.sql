WITH src_orders AS (
    SELECT order_id, shipping_service, shipping_cost, address_id, created_at, promo_id, estimated_delivery_at, 
    order_cost, user_id, order_total, delivered_at, tracking_id, status, _fivetran_deleted, _fivetran_synced
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
          md5(order_id) AS order_id
        , CASE 
              WHEN shipping_service = '' THEN 'Not service'
              ELSE shipping_service
          END AS shipping_service
        , CAST(shipping_cost AS FLOAT) AS shipping_cost
        , md5(address_id) AS address_id
        , CONVERT_TIMEZONE('UTC', created_at) AS created_at
        , CASE 
              WHEN promo_id = '' THEN md5('Not promo')
              ELSE md5(promo_id)
          END AS promo_id
        , CONVERT_TIMEZONE('UTC', estimated_delivery_at) AS estimated_delivery_at
        , CAST(order_cost AS FLOAT) AS order_cost
        , md5(user_id) AS user_id
        , CAST(order_total AS FLOAT) AS order_total
        , CONVERT_TIMEZONE('UTC', delivered_at) AS delivered_at
        , CAST(tracking_id AS VARCHAR(50)) AS tracking_id
        , CAST(status AS VARCHAR(50)) AS status
        , _fivetran_deleted AS date_deleted
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS _fivetran_synced
    FROM src_orders
    )

SELECT * FROM renamed_casted






