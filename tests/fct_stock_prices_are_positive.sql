select 
    stock_price_id,
    close_price_dkk
from {{ ref('fct_daily_market_performance')}}
where close_price_dkk < 0 