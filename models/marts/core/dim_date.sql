WITH macro_date AS (
    {{ dbt_utils.date_spine(datepart="day", start_date="CAST('2024-01-01' AS date)", end_date="CAST('2025-01-01' AS date)",) }}
),

dim_date AS (
    SELECT
          date_day
        , EXTRACT(year FROM date_day) AS year
        , EXTRACT(month FROM date_day) AS month
        , EXTRACT(day FROM date_day) AS day
    FROM macro_date
)

SELECT * FROM dim_date