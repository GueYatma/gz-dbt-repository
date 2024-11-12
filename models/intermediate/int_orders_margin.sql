with sales as (
    select 
        date_date,
        orders_id,
        pdt_id as product_id,
        revenue,
        quantity
    from {{ ref('stg_gz_raw_data__ventes_brutes_gz') }}
),

product as (
    select 
        products_id as product_id,
        purchase_price
    from {{ ref('stg_gz_raw_data__produit_brut_gz') }}
),

sales_with_costs as (
    select
        sales.date_date,
        sales.orders_id,
        sales.product_id,
        sales.revenue,
        sales.quantity,
        product.purchase_price,
        sales.quantity * product.purchase_price as purchase_cost
    from sales
    left join product
    on sales.product_id = product.product_id
)

select
    date_date,
    orders_id,
    product_id,
    revenue,
    quantity,          -- Assurez-vous que `quantity` est bien sélectionné ici
    purchase_cost,
    revenue - purchase_cost as margin
from sales_with_costs
