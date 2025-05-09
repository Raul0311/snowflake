WITH src_promos AS (
    SELECT promo_id, discount, status, _fivetran_deleted
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),

new_row AS (
    SELECT 
          dm5("Not promo") AS promo_id
          'Not promo' AS name
        , 0 AS discount
        , 'active' AS status
        , NULL AS date_deleted
    ),

renamed_casted AS (
    SELECT
          dm5('promo_id') AS promo_id
        , promo_id AS name
        , CAST(discount AS FLOAT) AS discount
        , status
        , _fivetran_deleted AS date_deleted
    FROM src_promos
    UNION ALL 
    SELECT * FROM new_row
    )

SELECT * FROM renamed_casted