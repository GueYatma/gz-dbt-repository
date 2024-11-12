with sales as (
    -- On sélectionne les données de la table de ventes
    select 
        date_date,
        orders_id,
        pdt_id as product_id,
        revenue,
        quantity
    from {{ ref('stg_gz_raw_data__ventes_brutes_gz') }}
),

product as (
    -- On sélectionne les données de la table des produits
    select 
        products_id as product_id,
        purchase_price
    from {{ ref('stg_gz_raw_data__produit_brut_gz') }}
),

sales_with_costs as (
    -- On joint les tables sales et product pour calculer le coût d'achat
    select
        sales.date_date,
        sales.orders_id,
        sales.product_id,
        sales.revenue,
        sales.quantity,
        product.purchase_price,
        -- Calcul du coût d'achat
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
    purchase_cost,
    -- Calcul de la marge
    revenue - purchase_cost as margin
from sales_with_costs
