WITH src_product_stock AS (
    SELECT name, inventory, _fivetran_synced
    FROM {{ ref('base_sql_server_dbo__products') }}
    ),

renamed_casted AS (
    SELECT
          CAST(md5(CONCAT(inventory, '|', name)) AS VARCHAR(80)) AS inventory_id
        , inventory
        , _fivetran_synced
    FROM src_product_stock
    )

SELECT * FROM renamed_casted