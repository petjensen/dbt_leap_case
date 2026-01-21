with daily_market_data as (
    select * from {{ ref('fct_daily_market_performance') }}
),

outliers as (
    select
        trading_date,
        ticker_symbol,
        company_name,
        daily_return_pct,
        close_price_dkk,
        moving_avg_7_days,
        (close_price_dkk - moving_avg_7_days) as diviation_from_avg
    from daily_market_data
    where
        abs(daily_return_pct) >= 50
)
select * from outliers
ORDER by abs(daily_return_pct) desc