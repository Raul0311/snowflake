WITH stg_product_stock AS (
    SELECT inventory_id, inventory
    FROM {{ ref('stg_sql_server_dbo__product_stock') }}
    ),

renamed_casted AS (
    SELECT
          inventory_id
        , inventory
    FROM stg_product_stock
    )

SELECT * FROM renamed_casted