with 

source as (

    select * from {{ source('gz_raw_data', 'produit_brut_gz') }}

),

renamed as (

    select
        products_id,
        CAST (purchse_price AS FLOAT64) AS purchase_price

    from source

)

select * from renamed
