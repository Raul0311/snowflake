{% snapshot product_stock_timestamp_snp %}

{{
    config(
      target_schema='snapshots',
      unique_key='inventory_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
      hard_deletes='invalidate',
    )
}}

select * from {{ ref('stg_sql_server_dbo__product_stock') }}

{% endsnapshot %}