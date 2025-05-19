WITH stg_events AS (
    SELECT event_id, page_url, event_type_id, user_id, product_id, session_id, created_at
    FROM {{ ref('stg_sql_server_dbo__events') }}
    ),

renamed_casted AS (
    SELECT
          event_id
        , page_url
        , event_type_id
        , user_id
        , product_id
        , session_id
        , created_at
    FROM stg_events
    )

SELECT * FROM renamed_casted