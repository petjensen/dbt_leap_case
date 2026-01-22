with companies_source as (
    select * from {{ ref('stg_company_metadata')}}
),

prices as (
    select p.* 
from {{ ref('stg_stock_prices')}} p 
inner join companies_source c
    on p.ticker_symbol = c.ticker_symbol
    and p.stock_exchange_symbol = c.stock_exchange_symbol
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
        c.company_name,
        p.ticker_symbol,
        p.closing_price_usd,
        (p.closing_price_usd * fx.rate_to_usd) as close_price_dkk
    from prices p
    inner join companies c
        on p.ticker_symbol = c.ticker_symbol
    inner join fx_rates fx
        on p.trading_date = fx.fx_date
)
select * from joined

