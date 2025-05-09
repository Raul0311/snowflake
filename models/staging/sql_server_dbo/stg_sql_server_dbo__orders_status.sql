WITH src_orders_status AS (
    SELECT status
    FROM {{ ref('base_sql_server_dbo__orders') }}
    ),

renamed_casted AS (
    SELECT
          md5('status') AS status_id
        , status
    FROM src_orders_status
    )

SELECT * FROM renamed_casted