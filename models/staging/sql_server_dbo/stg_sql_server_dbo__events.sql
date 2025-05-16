WITH src_events AS (
    SELECT event_id, page_url, event_type, user_id, product_id, session_id, created_at, order_id, 
            date_deleted
    FROM {{ ref('base_sql_server_dbo__events') }}
    ),

renamed_casted AS (
    SELECT
          event_id
        , page_url
        , md5(event_type) AS event_type_id
        , user_id
        , product_id
        , session_id
        , created_at
        , order_id
        , date_deleted
    FROM src_events
    )

SELECT * FROM renamed_casted