WITH src_users AS (
    SELECT user_id, updated_at, address_id, last_name, phone_number, first_name, email, _fivetran_deleted
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

renamed_casted AS (
    SELECT
          md5(user_id) AS user_id
        , CONVERT_TIMEZONE('UTC', updated_at) AS updated_at
        , md5(address_id) AS address_id
        , CAST(last_name AS VARCHAR(50)) AS last_name
        , CAST(REPLACE(phone_number, '-', '') AS INT) AS phone_number
        , CAST(first_name AS VARCHAR(50)) AS first_name
        , CAST(email AS VARCHAR(50)) AS email
        , _fivetran_deleted AS date_deleted
    FROM src_users
    )

SELECT * FROM renamed_casted