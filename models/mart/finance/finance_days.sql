
with orders_data as (
    select 
        date_date,
        orders_id,
        revenue,
        quantity,
        margin,
        operational_margin,
        purchase_cost,
        shipping_fee,
        logcost
    from {{ ref('int_orders_operational') }}
)

select 
    date_date,
    count(distinct orders_id) as nb_transactions,         -- Nombre total de transactions
    sum(revenue) as revenue,                              -- Chiffre d'affaires total
    sum(revenue) / count(distinct orders_id) as average_basket, -- Panier moyen
    sum(margin) as margin,                                -- Marge totale
    sum(operational_margin) as operating_margin,          -- Marge opérationnelle totale
    sum(purchase_cost) as total_purchase_cost,            -- Coût total d'achat
    sum(shipping_fee) as total_shipping_fee,              -- Frais de livraison totaux
    sum(logcost) as total_log_cost,                       -- Coût logistique total
    sum(quantity) as total_quantity_sold                  -- Quantité totale de produits vendus
from orders_data
group by date_date
order by date_date


