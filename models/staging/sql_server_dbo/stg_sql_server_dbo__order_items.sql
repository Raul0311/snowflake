WITH src_order_items AS (
    SELECT order_id, product_id, quantity, _fivetran_deleted
    FROM {{ source('sql_server_dbo', 'order_items') }}
    ),

renamed_casted AS (
    SELECT
          md5(order_id) AS order_id
        , md5(product_id) AS product_id
        , CAST(quantity AS INT) AS quantity
        , _fivetran_deleted AS date_deleted
    FROM src_order_items
    )

SELECT * FROM renamed_casted