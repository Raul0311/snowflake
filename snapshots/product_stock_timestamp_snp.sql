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

select * from {{ ref('dim_product_stock') }}

{% endsnapshot %}