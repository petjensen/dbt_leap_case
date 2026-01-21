{{ config(
    materialized = 'table'
)}}

with performance_data as (
    select * from {{ ref('int_company_performance_enriched') }}
),
final as (
    select
        stock_price_id,
        trading_date, 
        ticker_symbol,
        company_name,
        close_price_dkk,
        daily_return_pct,
        moving_avg_7_days
    from performance_data
    order by trading_date desc, ticker_symbol asc
)

select * from final

