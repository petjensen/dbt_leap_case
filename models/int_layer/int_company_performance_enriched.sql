with daily_prices as (
    select * from {{ ref('int_daily_stock_prices') }}
),

calculations as (
    select
        stock_price_id,
        trading_date,
        ticker_symbol,
        company_name,
        close_price_dkk,

        LAG(close_price_dkk) over (PARTITION by ticker_symbol order by trading_date) as prev_day_price_dkk,

        AVG(close_price_dkk) over (
            PARTITION BY ticker_symbol
            ORDER BY trading_date
            ROWS BETWEEN 6 preceding and current row
        ) as moving_avg_7_days
    from daily_prices
),

performance_metrics as (
    select 
        *,
        ((close_price_dkk - prev_day_price_dkk) / nullif(prev_day_price_dkk, 0)) * 100 as daily_return_pct
    from calculations
)
select * from performance_metrics

