WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key('address_id') }} AS address_id
        , CAST(zipcode AS INT) AS zipcode
        , CAST(country AS VARCHAR(50)) AS country
        , CAST(address AS VARCHAR(50)) AS address
        , CAST(state AS VARCAHR(50)) AS state
        , _fivetran_deleted AS date_deleted
        , CONVERT_TIMEZONE('UTC', au._fivetran_synced) AS date_load
    FROM src_addresses
    )

SELECT * FROM renamed_casted;