with 

source as (

    select * from {{ source('gz_raw_data', 'ventes_brutes_gz') }}

),

renamed as (

    select
        date_date,
        orders_id,
        pdt_id,
        revenue,
        quantity

    from source

)

select * from renamed
