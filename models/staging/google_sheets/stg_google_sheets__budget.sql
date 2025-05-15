WITH src_budget AS (
    SELECT _row, product_id, quantity, month
    FROM {{ source('google_sheets', 'budget') }}
    ),

renamed_casted AS (
    SELECT
          md5(_row) AS budget_id
        , CAST(_row AS FLOAT) AS _row
        , md5(product_id) AS product_id
        , CAST(quantity AS FLOAT) AS quantity
        , CAST(month AS DATE) AS month
    FROM src_budget
    )

SELECT * FROM renamed_casted