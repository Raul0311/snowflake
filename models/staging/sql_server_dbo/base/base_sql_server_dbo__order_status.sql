WITH src_orders AS (
    SELECT DISTINCT status
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key('status') }} AS status_id
        , status
    FROM src_orders
    )

SELECT * FROM renamed_casted;