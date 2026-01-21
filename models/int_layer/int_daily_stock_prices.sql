with prices as (
    select * from {{ ref('stg_stock_prices')}}
),

companies as (
    select * from {{ref('stg_company_metadata')}} 
),

fx_rates as (
    select * from {{ ref('stg_fx_rates')}}
),

joined as (
    select
        p.stock_price_id,
        p.trading_date,
        p.ticker_symbol,
        c.company_name,
        p.closing_price_usd,
        (p.closing_price_usd * fx.rate_to_usd) as close_price_dkk
    from prices p
    left join companies c
        on p.ticker_symbol = c.ticker_symbol
    left join fx_rates fx
        on p.trading_date = fx.fx_date
)
select * from joined

