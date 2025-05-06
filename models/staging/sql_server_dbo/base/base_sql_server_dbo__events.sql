WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
    ),

WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

cleaning_ids_of_relationships AS (
    SELECT
          e.event_id
        , e.page_url
        , e.event_type
        , e.user_id
        , e.product_id
        , e.session_id
        , e.created_at
        , e.order_id
        , e._fivetran_synced AS date_load
        , e._fivetran_deleted AS date_deleted
    FROM src_events e
    JOIN src_products p ON e.product_id = p.product_id
    JOIN src_orders o ON e.order_id = o.order_id 
    )

SELECT * FROM cleaning_ids_of_relationships