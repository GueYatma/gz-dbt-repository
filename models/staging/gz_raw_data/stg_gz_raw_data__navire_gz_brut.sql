with 

source as (

    select * from {{ source('gz_raw_data', 'navire_gz_brut') }}

),

renamed as (

    select
        orders_id,
        shipping_fee,
        logcost,
        ship_cost
        cast(ship_cost as FLOAT64) as ship_cost  -- Conversion de ship_cost en FLOAT64
    from source
    where shipping_fee <> shipping_fee_1  -- Filtrage des lignes où shipping_fee est différent de shipping_fee_1
)

select * from renamed
