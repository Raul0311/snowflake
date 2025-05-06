WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
    ),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key('_row') }} AS _row
        , product_id
        , CAST(quantity AS FLOAT) AS quantity
        , CAST(month AS DATE) AS month
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS date_load
    FROM src_budget
    )

SELECT * FROM renamed_casted