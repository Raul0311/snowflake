WITH macro_date AS (
    {{ dbt_utils.date_spine(datepart="minute", start_date="CAST('2024-01-01' AS date)", end_date="CAST('2024-01-02' AS date)",) }}
),

dim_time AS (
    SELECT 
          DISTINCT TO_CHAR(date_minute, 'HH24:MI') AS full_hour_minute
        , EXTRACT(HOUR FROM date_minute) AS hour
        , EXTRACT(MINUTE FROM date_minute) AS minute
    FROM macro_date
)

SELECT * FROM dim_time