WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key('order_id') }} AS order_id
        , CASE 
              WHEN shipping_service = '' THEN 'Not service'
              ELSE shipping_service
          END AS shipping_service
        , CAST(shipping_cost AS FLOAT) AS shipping_cost
        , {{ dbt_utils.generate_surrogate_key('address_id') }} AS address_id
        , CONVERT_TIMEZONE('UTC', created_at) AS created_at
        , CASE 
              WHEN promo_id = '' THEN {{ dbt_utils.generate_surrogate_key(["'Not promo'"]) }}
              ELSE promo_id
          END AS promo_id
        , CONVERT_TIMEZONE('UTC', estimated_delivery_at) AS estimated_delivery_at
        , CAST(order_cost AS FLOAT) AS order_cost
        , {{ dbt_utils.generate_surrogate_key('user_id') }} AS user_id
        , CAST(order_total AS FLOAT) AS order_total
        , CONVERT_TIMEZONE('UTC', delivered_at) AS delivered_at
        , CAST(tracking_id AS VARCHAR(50)) AS tracking_id
        , {{ dbt_utils.generate_surrogate_key('status') }} AS status
        , _fivetran_deleted AS date_deleted
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted