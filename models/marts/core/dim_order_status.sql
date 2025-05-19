WITH stg_order_status AS (
    SELECT status_id, status
    FROM {{ ref('stg_sql_server_dbo__order_status') }}
    ),

renamed_casted AS (
    SELECT
          status_id
        , status
    FROM stg_order_status
    )

SELECT * FROM renamed_casted