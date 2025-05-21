WITH date_limits AS (
    SELECT 
          MIN(DATE(created_at)) AS start_date
        , MAX(DATE(created_at)) AS end_date
    FROM {{ ref('fct_orders') }}
),

date_range AS (
    SELECT 
        DATEADD(day, SEQ4(), (SELECT start_date FROM date_limits)) AS date_day
    FROM TABLE(GENERATOR(ROWCOUNT => 2000))
),

filtered_dates AS (
    SELECT *
    FROM date_range
    WHERE date_day <= (SELECT end_date FROM date_limits)
),

dim_date AS (
    SELECT
          date_day
        , EXTRACT(year FROM date_day) AS year
        , EXTRACT(month FROM date_day) AS month
        , EXTRACT(day FROM date_day) AS day
        , TO_CHAR(date_day, 'YYYY-MM') AS year_month
        , EXTRACT(dayofweek FROM date_day) AS weekday_number
        , INITCAP(TO_CHAR(date_day, 'Day')) AS weekday_name
        , INITCAP(TO_CHAR(date_day, 'Month')) AS month_name
        , EXTRACT(week FROM date_day) AS week_number
        , EXTRACT(quarter FROM date_day) AS quarter
        , CASE 
              WHEN EXTRACT(dayofweek FROM date_day) IN (1, 7) THEN 'Weekend'
              ELSE 'Weekday'
          END AS day_type
    FROM filtered_dates
)

SELECT * FROM dim_date