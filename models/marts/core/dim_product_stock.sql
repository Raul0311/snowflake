WITH stg_product_stock AS (
    SELECT inventory_id, inventory, dbt_updated_at
    FROM {{ ref('product_stock_timestamp_snp') }}
    ),

renamed_casted AS (
    SELECT
          inventory_id
        , inventory
        , dbt_updated_at
    FROM stg_product_stock
    )

SELECT * FROM renamed_casted