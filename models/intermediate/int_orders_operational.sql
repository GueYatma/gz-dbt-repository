with orders_margin as (
    -- On récupère les marges calculées par commande
    select 
        orders_id,
        date_date,
        revenue,
        quantity,
        purchase_cost,
        margin
    from {{ ref('int_orders_margin') }}
),

shipping_costs as (
    -- On récupère les informations de transport
    select 
        orders_id,
        shipping_fee,
        logcost,
        cast(ship_cost as FLOAT64) as ship_cost  -- Conversion de ship_cost en FLOAT64
    from {{ ref('stg_gz_raw_data__navire_gz_brut') }}
),

operational_margin_calc as (
    -- On joint les deux CTEs précédents pour calculer la marge opérationnelle
    select
        orders_margin.orders_id,
        orders_margin.date_date,
        orders_margin.revenue,
        orders_margin.quantity,
        orders_margin.purchase_cost,
        orders_margin.margin,
        shipping_costs.shipping_fee,
        shipping_costs.logcost,
        shipping_costs.ship_cost,
        -- Calcul de la marge opérationnelle
        orders_margin.margin + shipping_costs.shipping_fee - shipping_costs.logcost - shipping_costs.ship_cost as operational_margin
    from orders_margin
    left join shipping_costs on orders_margin.orders_id = shipping_costs.orders_id
)

select
    orders_id,
    date_date,
    operational_margin,
    quantity
from operational_margin_calc
