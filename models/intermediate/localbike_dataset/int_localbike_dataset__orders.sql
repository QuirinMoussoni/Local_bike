with order_item_grouped_by_order as (
  SELECT
    order_id,
    product_id,
    SUM((quantity * list_price) -  (quantity * list_price * discount)) as total_order_amount,
    SUM(quantity) as total_items,
    COUNT(DISTINCT product_id) as total_distinct_items
  FROM 
    {{ref('stg_localbike_dataset__order_items')}}
  GROUP BY
    order_id,
    product_id
), 
stores_grouped_by_order as (
  SELECT
    store_id,
    store_name,
    state,
    zip_code
  FROM 
    {{ref('stg_localbike_dataset__stores')}}
)

SELECT
  o.order_id,
  o.order_status,
  o.order_created_at,
  o.store_id,
  oi.product_id,
  oi.total_order_amount,
  oi.total_items,
  oi.total_distinct_items,
  s.store_name,
  s.state,
  s.zip_code
FROM  order_item_grouped_by_order as oi
LEFT JOIN {{ref('stg_localbike_dataset__orders')}} as o
USING(order_id)
LEFT JOIN stores_grouped_by_order as s
USING(store_id)
