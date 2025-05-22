WITH src_order_status AS (
    SELECT status
    FROM {{ ref('base_sql_server_dbo__orders') }}
    ),

renamed_casted AS (
    SELECT
          DISTINCT md5(status) AS status_id
        , status
    FROM src_order_status
    )

SELECT * FROM renamed_casted