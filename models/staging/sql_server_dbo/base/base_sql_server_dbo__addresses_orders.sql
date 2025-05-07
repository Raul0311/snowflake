WITH src_addresses_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),

src_orders AS (
    SELECT address_id
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key('ao.address_id') }} AS address_id
        , CAST(ao.zipcode AS INT) AS zipcode
        , ao.country
        , ao.address
        , ao.state
        , ao._fivetran_deleted AS date_deleted
        , CONVERT_TIMEZONE('UTC', ao._fivetran_synced) AS date_load
    FROM src_addresses_orders ao
    JOIN src_orders o
    ON ao.address_id = o.address_id
    )

SELECT * FROM renamed_casted;