WITH src_order_status AS (
    SELECT status
    FROM {{ ref('orders_timestamp_snp') }}
    ),

renamed_casted AS (
    SELECT
          DISTINCT md5(status) AS status_id
        , status
    FROM src_order_status
    )

SELECT * FROM renamed_casted