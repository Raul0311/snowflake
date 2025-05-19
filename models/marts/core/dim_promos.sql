WITH stg_promos AS (
    SELECT promo_id, name, discount, status
    FROM {{ ref('stg_sql_server_dbo__promos') }}
    ),

renamed_casted AS (
    SELECT
          promo_id
        , name
        , discount
        , status
    FROM stg_promos
    )

SELECT * FROM renamed_casted