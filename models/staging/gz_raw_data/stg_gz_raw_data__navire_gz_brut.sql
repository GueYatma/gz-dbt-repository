with 

source as (
    select * from {{ source('gz_raw_data', 'navire_gz_brut') }}
),

renamed as (
    select
        orders_id,
        shipping_fee,
        logcost,
        CAST(ship_cost AS INT) AS ship_cost  -- Utilise safe_cast pour éviter les erreurs de conversion
    from source
)

select * from renamed