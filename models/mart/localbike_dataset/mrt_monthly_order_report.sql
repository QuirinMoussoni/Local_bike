{{
  config(
    alias = "order_monthly_report",
  )
}}

SELECT 
  DATE(o.order_created_at) as order_date,
  t.first_name,
  t.last_name,
  t.manager_id,
  -- comments
  COUNT(DISTINCT o.order_id) as total_orders,
  ROUND(AVG(o.total_items),0) as avg_item_per_orders,
  ROUND(o.total_items, 0) as total_items,
  ROUND(AVG(o.total_order_amount),2) as avg_amount_spent_per_order,
  b.product_name,
  b.category_name,
  b.brand_name,
  o.store_name,
  o.total_order_amount,
  s.state
FROM 
  {{ref('int_localbike_dataset__brand')}} as b
LEFT JOIN
  {{ref('int_localbike_dataset__orders')}} as o
USING(product_id)
LEFT JOIN
  {{ref('int_localbike_dataset__state')}} as s
USING(product_id)
LEFT JOIN 
  {{ref('stg_localbike_dataset__staffs')}} as t
USING(staff_id)
GROUP BY 
  t.first_name,
  t.last_name,
  t.manager_id,
  total_items,
  order_date,
  s.state,
  b.product_name,
  b.category_name,
  b.brand_name,
  o.store_name,
  o.total_order_amount
