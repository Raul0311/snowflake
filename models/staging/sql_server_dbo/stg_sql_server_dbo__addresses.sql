WITH src_addresses AS (
    SELECT address_id, zipcode, country, address, state, _fivetran_deleted
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),

renamed_casted AS (
    SELECT
          md5(address_id) AS address_id
        , CAST(zipcode AS INT) AS zipcode
        , CAST(country AS VARCHAR(50)) AS country
        , CAST(address AS VARCHAR(50)) AS address
        , CAST(state AS VARCHAR(50)) AS state
        , _fivetran_deleted AS date_deleted
    FROM src_addresses
    )

SELECT * FROM renamed_casted