{{
    config(
        materialized='incremental'
    )
}}

WITH stg_orders AS (
    SELECT DISTINCT order_id, created_at, estimated_delivery_at, delivered_at
    FROM {{ ref('stg_sql_server_dbo__orders') }}
    ),

renamed_casted AS (
    SELECT
          CAST(md5(CONCAT(order_id, '|', created_at)) AS VARCHAR(80)) AS delivered_id
        , order_id
        , created_at
        , estimated_delivery_at
        , delivered_at
    FROM stg_orders
    )

SELECT * FROM renamed_casted