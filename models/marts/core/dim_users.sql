{{
    config(
        materialized='incremental',
        unique_key = 'user_id'
    )
}}

WITH stg_users AS (
    SELECT user_id, updated_at, address_id, last_name, phone_number, first_name, email
    FROM {{ ref('stg_sql_server_dbo__users') }}
    ),

renamed_casted AS (
    SELECT
          user_id
        , updated_at
        , address_id
        , last_name
        , phone_number
        , first_name
        , email
    FROM stg_users
    )

SELECT * FROM renamed_casted