{% snapshot orders_timestamp_snp %}

{{
    config(
      target_schema='snapshots',
      unique_key='order_id',
      strategy='timestamp',
      updated_at='created_at',
      hard_deletes='invalidate',
    )
}}

select * from {{ ref('dim_orders_delivered_at') }}

{% endsnapshot %}