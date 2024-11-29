WITH orders_summary as (
  SELECT
    s.store_id,
    s.store_name,
    SUM((oi.quantity * oi.list_price) -  (oi.quantity * oi.list_price * oi.discount)) AS total_order_discounted,
    SUM(oi.quantity) as total_items,
    COUNT(DISTINCT oi.product_id) as total_distinct_item,
    COUNT(DISTINCT oi.order_id) as total_orders
  FROM 
    {{ref('stg_localbike_dataset__order_items')}} as oi
  LEFT JOIN 
    {{ref('stg_localbike_dataset__orders')}} as o
ON 
o.order_id = oi.order_id
  LEFT JOIN 
    {{ref('stg_localbike_dataset__stores')}} as s
ON 
  o.store_id = s.store_id
GROUP BY 
    s.store_id,
    s.store_name
),

product_sumary as (
  SELECT
    oi.product_id,
    o.store_id,
    ROW_NUMBER()
    OVER(
      PARTITION BY o.store_id
      ORDER BY SUM(oi.quantity) DESC
    ) as rn
  FROM {{ref('stg_localbike_dataset__orders')}} as o
  LEFT JOIN
    {{ref('stg_localbike_dataset__order_items')}} as oi
  USING(order_id)
  GROUP BY 
    oi.product_id,
    o.store_id
)

SELECT 
  o.store_id,
  o.store_name,
  p.product_id,
  o.total_order_discounted,
  o.total_items,
  o.total_distinct_item,
  o.total_orders
FROM
  orders_summary as o 
LEFT JOIN 
  product_sumary as p 
ON 
  o.store_id = p.store_id
AND
  p.rn = 1
