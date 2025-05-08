WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
    ),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key('event_id') }} AS event_id
        , CAST(page_url AS VARCHAR(256)) AS page_url
        , event_type
        , {{ dbt_utils.generate_surrogate_key('user_id') }} AS user_id
        , CASE 
              WHEN product_id = '' THEN {{ dbt_utils.generate_surrogate_key(["'Not product'"]) }}
              ELSE {{ dbt_utils.generate_surrogate_key('product_id') }}
          END AS product_id
        , CAST(session_id AS VARCHAR(50)) AS session_id
        , CONVERT_TIMEZONE('UTC', CAST(created_at AS TIMESTAMP)) AS created_at
        , CASE 
              WHEN order_id = '' THEN {{ dbt_utils.generate_surrogate_key(["'Not order'"]) }}
              ELSE {{ dbt_utils.generate_surrogate_key('order_id') }}
          END AS order_id
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS date_load
        , _fivetran_deleted AS date_deleted
    FROM src_events
    )

SELECT * FROM renamed_casted