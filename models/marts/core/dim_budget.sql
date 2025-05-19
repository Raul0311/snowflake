WITH stg_budget AS (
    SELECT budget_id, _row, product_id, quantity, month
    FROM {{ ref('stg_google_sheets__budget') }}
    ),

renamed_casted AS (
    SELECT
          budget_id
        , _row
        , product_id
        , quantity
        , month
    FROM stg_budget
    )

SELECT * FROM renamed_casted