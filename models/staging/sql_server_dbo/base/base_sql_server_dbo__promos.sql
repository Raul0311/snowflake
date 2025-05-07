WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),

new_row AS (
    SELECT 
          {{ dbt_utils.generate_surrogate_key(["'Not promo'"]) }} AS promo_id
          'Not promo' AS name
        , 0 AS discount
        , 'active' AS status
        , NULL AS date_deleted
        , '2025-05-06T17:02:24.597+02:00' AS date_load
    ),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key('promo_id') }} AS promo_id
        , promo_id AS name
        , CAST(discount AS FLOAT) AS discount
        , status
        , _fivetran_deleted AS date_deleted
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS date_load
    FROM src_promos
    UNION ALL 
    SELECT * FROM new_row
    )

SELECT * FROM renamed_casted