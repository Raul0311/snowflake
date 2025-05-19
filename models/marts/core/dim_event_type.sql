WITH stg_event_type AS (
    SELECT event_id, event_type
    FROM {{ ref('stg_sql_server_dbo__event_type') }}
    ),

renamed_casted AS (
    SELECT
          event_id
        , event_type
    FROM stg_event_type
    )

SELECT * FROM renamed_casted