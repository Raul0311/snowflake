WITH src_event_type AS (
    SELECT event_type
    FROM {{ ref('base_sql_server_dbo__events') }}
    ),

renamed_casted AS (
    SELECT
          DISTINCT md5(event_type) as event_id
        , event_type
    FROM src_event_type
    )

SELECT * FROM renamed_casted