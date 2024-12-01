SELECT 
  oi.order_id,
  oi.product_id,
  oi.order_item_id,
  p.product_name,
  p.category_id,
  p.brand_id,
  c.category_name,
  b.brand_name
FROM
  {{ref('stg_localbike_dataset__order_items')}} as oi
LEFT JOIN 
  {{ref('stg_localbike_dataset__products')}} as p
USING(product_id)
LEFT JOIN
  {{ref('stg_localbike_dataset__categories')}} as c
USING(category_id)
LEFT JOIN
  {{ref('stg_localbike_dataset__brands')}} as b
USING(brand_id)
