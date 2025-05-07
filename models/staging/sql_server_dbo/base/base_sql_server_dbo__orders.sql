WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
          order_id
        , CASE 
              WHEN shipping_service = '' THEN 'No service'
              ELSE shipping_service
          END AS shipping_service
        , CAST(shipping_cost AS FLOAT) AS shipping_cost
        , address_id
        , CONVERT_TIMEZONE('UTC', created_at) AS created_at
        , CASE 
              WHEN promo_id = '' THEN 'No promo'
              ELSE promo_id
          END AS promo_id
        , CONVERT_TIMEZONE('UTC', estimated_delivery_at) AS estimated_delivery_at
        , CAST(order_cost AS FLOAT) AS order_cost
        , user_id
        , CAST(order_total AS FLOAT) AS order_total
        , CONVERT_TIMEZONE('UTC', delivered_at) AS delivered_at
        , tracking_id
        , status
        , _fivetran_deleted AS date_deleted
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted