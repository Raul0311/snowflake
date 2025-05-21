WITH total_spent_per_user AS (
    SELECT
          user_id
        , SUM(product_cost * quantity) AS total_spent
    FROM {{ ref('fct_orders') }}
    GROUP BY user_id
),

users_info AS (
    SELECT
          user_id
        , first_name
        , last_name
        , email
    FROM {{ ref('dim_users') }}
)

SELECT
      u.user_id
    , u.first_name
    , u.last_name
    , u.email
    , tspu.total_spent
    , RANK() OVER (ORDER BY tspu.total_spent DESC) AS ranking
FROM total_spent_per_user tspu
JOIN users_info u
ON tspu.user_id = u.user_id
ORDER BY ranking