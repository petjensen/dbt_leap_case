with raw_prices as (
    select * from {{ source('public_data', 'stock_price_timeseries')}}
),

renamed as (
    select
        md5(cast(concat(ticker, date, PRIMARY_EXCHANGE_CODE) as string)) as stock_price_id,
        ticker as ticker_symbol,
        PRIMARY_EXCHANGE_CODE as stock_exchange_symbol,
        date::DATE as trading_date,
        value as closing_price_usd
    from raw_prices
    where variable = 'post-market_close_adjusted' and PRIMARY_EXCHANGE_CODe is not null
)
select * from renamed