{{ config(
    materialized = 'table'
)}}

with market_data as (
    select * from {{ ref('fct_daily_market_performance') }}
),

summary as (
    select
        ticker_symbol,
        company_name,
        min(close_price_dkk) as all_time_low_dkk,
        max(close_price_dkk) as all_time_high_dkk,
        avg(close_price_dkk) as avg_price_dkk,
        max(trading_date) as last_updated_date,
        max(abs(daily_return_pct)) as max_daily_swing_pct,
        count(distinct ticker_symbol) as ticker_count
    from market_data
    group by 1, 2
    order by ticker_count desc
)

select * from summary
