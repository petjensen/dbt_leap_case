with raw_fx_rates as (
    select * from {{ source('public_data', 'fx_rates_timeseries')}}
),

renamed_cleaned_fx as (
    select 
        md5(cast(concat(QUOTE_CURRENCY_ID, date) as string)) as fx_rate_id,
        UPPER(QUOTE_CURRENCY_ID) as currency_code,
        QUOTE_CURRENCY_NAME as currency_name,
        date::DATE as fx_date,
        "VALUE"::FLOAT as rate_to_usd
    from raw_fx_rates
    where BASE_CURRENCY_ID = 'USD'
        and value > 0 
    order by date desc 
)

select * from renamed_cleaned_fx

