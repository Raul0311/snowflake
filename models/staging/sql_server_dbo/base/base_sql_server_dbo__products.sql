WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

new_row AS (
    SELECT 
          'No product' AS product_id
        , 0 AS price
        , 'Not applicable' AS name
        , 0 AS inventory
        , NULL AS date_deleted
        , '2025-05-06T17:02:24.597+02:00' AS date_load
    ),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key('product_id') }} AS product_id
        , CAST(price AS FLOAT) AS price
        , name
        , CAST(inventory AS INT) AS inventory
        , _fivetran_deleted AS date_deleted
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS date_load
    FROM src_products
    UNION ALL 
    SELECT * FROM new_row
    )

SELECT * FROM renamed_casted