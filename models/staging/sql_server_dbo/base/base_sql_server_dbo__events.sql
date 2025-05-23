WITH src_events AS (
    SELECT event_id, page_url, event_type, user_id, product_id, session_id, created_at, order_id, 
            _fivetran_deleted, _fivetran_synced
    FROM {{ source('sql_server_dbo', 'events') }}
    ),

renamed_casted AS (
    SELECT
          md5(event_id) AS event_id
        , CAST(page_url AS VARCHAR(256)) AS page_url
        , CAST(event_type AS VARCHAR(50)) AS event_type
        , md5(user_id) AS user_id
        , CASE 
              WHEN product_id = '' THEN md5('Not product')
              ELSE md5(product_id)
          END AS product_id
        , CAST(session_id AS VARCHAR(50)) AS session_id
        , CONVERT_TIMEZONE('UTC', CAST(created_at AS TIMESTAMP)) AS created_at
        , CASE 
              WHEN order_id = '' THEN md5('Not order')
              ELSE md5(order_id)
          END AS order_id
        , _fivetran_deleted AS date_deleted
        , CONVERT_TIMEZONE('UTC', CAST(_fivetran_synced AS TIMESTAMP)) AS _fivetran_synced
    FROM src_events
    )

SELECT * FROM renamed_casted






