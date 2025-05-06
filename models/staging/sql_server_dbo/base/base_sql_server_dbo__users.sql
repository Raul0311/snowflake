WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key('user_id') }} AS user_id
        , CONVERT_TIMEZONE('UTC', CAST(updated_at AS TIMESTAMP)) AS updated_at
        , address_id
        , last_name
        , CONVERT_TIMEZONE('UTC', CAST(created_at AS TIMESTAMP)) AS created_at
        , phone_number
        , CAST(total_orders AS INT) AS total_orders
        , first_name
        , email
        , _fivetran_deleted AS date_deleted
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS date_load
    FROM src_promos
    )

SELECT * FROM renamed_casted;