WITH src_products AS (
    SELECT product_id, price, name, inventory, _fivetran_deleted
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

new_row AS (
    SELECT 
          md5('Not product') AS product_id
        , 0 AS price
        , 'Not product' AS name
        , 0 AS inventory
        , NULL AS date_deleted
    ),

renamed_casted AS (
    SELECT
          md5(product_id) AS product_id
        , CAST(price AS FLOAT) AS price
        , CAST(name AS VARCHAR(50)) AS name
        , CAST(inventory AS INT) AS inventory
        , _fivetran_deleted AS date_deleted
    FROM src_products
    UNION ALL 
    SELECT * FROM new_row
    )

SELECT * FROM renamed_casted