WITH src_users AS (
    SELECT user_id, updated_at, address_id, last_name, created_at, phone_number, first_name, email, _fivetran_deleted, _fivetran_synced
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key('user_id') }} AS user_id
        , CONVERT_TIMEZONE('UTC', CAST(updated_at AS TIMESTAMP)) AS updated_at
        , {{ dbt_utils.generate_surrogate_key('address_id') }} AS address_id
        , CAST(last_name AS VARCAHR(50)) AS last_name
        , CONVERT_TIMEZONE('UTC', CAST(created_at AS TIMESTAMP)) AS created_at
        , CAST(phone_number AS INT) AS phone_number
        , CAST(first_name AS VARCHAR(50))
        , CAST(email AS VARCHAR(50)) AS email
        , _fivetran_deleted AS date_deleted
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS date_load
    FROM src_users
    )

SELECT * FROM renamed_casted;