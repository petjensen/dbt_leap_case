with company_index as (
    select * from {{ source('public_data', 'company_index')}}
),

company_metadata as (
    select
        company_id as company_id,
        company_name as company_name,
        entity_level as asset_class,
        UPPER(primary_ticker) as ticker_symbol,
        UPPER(PRIMARY_EXCHANGE_CODE) as stock_exchange_symbol
    from company_index
    where primary_ticker is not null
    qualify row_number() over (
        partition by upper(primary_ticker)
        order by company_name
    ) = 1
)
select * from company_metadata