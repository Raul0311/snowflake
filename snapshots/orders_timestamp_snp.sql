{% snapshot orders_timestamp_snp %}

{{
    config(
      target_schema='snapshots',
      unique_key='order_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
      hard_deletes='invalidate',
    )
}}

select * from {{ ref('stg_sql_server_dbo__orders') }}

{% endsnapshot %}