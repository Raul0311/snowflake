WITH stg_addresses AS (
    SELECT address_id, zipcode, country, address, state
    FROM {{ ref('stg_sql_server_dbo__addresses') }}
    ),

renamed_casted AS (
    SELECT
          address_id
        , zipcode
        , country
        , address
        , state
    FROM stg_addresses
    )

SELECT * FROM renamed_casted