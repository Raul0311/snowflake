WITH src_addresses_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),

src_users AS (
    SELECT address_id
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key('au.address_id') }} AS address_id
        , CAST(au.zipcode AS INT) AS zipcode
        , au.country
        , au.address
        , au.state
        , au._fivetran_deleted AS date_deleted
        , CONVERT_TIMEZONE('UTC', au._fivetran_synced) AS date_load
    FROM src_addresses_users au
    JOIN src_users u
    ON au.address_id = u.address_id
    )

SELECT * FROM renamed_casted;