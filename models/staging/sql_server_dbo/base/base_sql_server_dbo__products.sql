WITH src_products AS (
    SELECT product_id, price, name, inventory, _fivetran_deleted, _fivetran_synced
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

new_row AS (
    SELECT 
          md5('Not product') AS product_id
        , 0 AS price
        , 'Not product' AS name
        , 0 AS inventory
        , NULL AS date_deleted
        , '2025-05-19T12:08:00.482Z'
    ),

renamed_casted AS (
    SELECT
          md5(product_id) AS product_id
        , CAST(price AS FLOAT) AS price
        , CAST(name AS VARCHAR(50)) AS name
        , CAST(inventory AS INT) AS inventory
        , _fivetran_deleted AS date_deleted
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS _fivetran_synced
    FROM src_products
    UNION ALL 
    SELECT * FROM new_row
    )

SELECT * FROM renamed_casted






