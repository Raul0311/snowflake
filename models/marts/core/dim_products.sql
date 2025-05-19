WITH stg_products AS (
    SELECT product_id, price, name, inventory_id
    FROM {{ ref('stg_sql_server_dbo__products') }}
    ),

renamed_casted AS (
    SELECT
          product_id
        , price
        , name
        , inventory_id
    FROM stg_products
    )

SELECT * FROM renamed_casted