WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
    ),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key('event_id') }} AS event_id
        , page_url
        , event_type
        , user_id
        , CASE 
              WHEN product_id = '' THEN 'No product'
              ELSE product_id
          END AS product_id
        , session_id
        , created_at
        , CASE 
              WHEN order_id = '' THEN 'No order'
              ELSE order_id
          END AS order_id
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS date_load
        , _fivetran_deleted AS date_deleted
    FROM src_events
    )

SELECT * FROM renamed_casted