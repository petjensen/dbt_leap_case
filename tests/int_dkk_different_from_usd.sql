select 
    stock_price_id,
    closing_price_usd,
    close_price_dkk
from {{ref('int_daily_stock_prices')}}
where closing_price_usd = close_price_dkk