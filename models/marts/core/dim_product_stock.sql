WITH stg_product_stock AS (
    SELECT inventory_id, inventory, dbt_scd_id, dbt_updated_at, dbt_valid_from, dbt_valid_to
    FROM {{ ref('product_stock_timestamp_snp') }}
    ),

renamed_casted AS (
    SELECT
          inventory_id
        , inventory
        , dbt_scd_id
        , dbt_updated_at
        , dbt_valid_from
        , dbt_valid_to
    FROM stg_product_stock
    )

SELECT * FROM renamed_casted