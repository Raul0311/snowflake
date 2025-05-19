WITH src_products AS (
    SELECT product_id, price, name, inventory, date_deleted
    FROM {{ ref('base_sql_server_dbo__products') }}
    ),

renamed_casted AS (
    SELECT
          product_id
        , price
        , name
        , CAST(md5(CONCAT(inventory, '|', name)) AS VARCHAR(80)) AS inventory_id
        , date_deleted
    FROM src_products
    )

SELECT * FROM renamed_casted