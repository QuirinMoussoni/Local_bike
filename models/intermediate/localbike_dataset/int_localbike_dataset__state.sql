WITH customer_counts_per_product as (
  SELECT 
    oi.product_id,
    o.staff_id,
    COUNT(DISTINCT o.customer_id) as distinct_customer_count
  FROM
    {{ref('stg_localbike_dataset__order_items')}} as oi
  LEFT JOIN 
    {{ref('stg_localbike_dataset__orders')}} as o
  USING(order_id)
  LEFT JOIN 
    {{ref('stg_localbike_dataset__customers')}} as c
  USING(customer_id)
  GROUP BY 
    oi.product_id,
    o.staff_id
),

dominant_state_per_product as (
  SELECT
    oi.product_id,
    s.state,
    ROW_NUMBER() 
    OVER(
      PARTITION BY oi.product_id
      ORDER BY COUNT(DISTINCT o.customer_id) DESC
    ) as rn
  FROM 
    {{ref('stg_localbike_dataset__order_items')}} as oi 
  LEFT JOIN
    {{ref('stg_localbike_dataset__orders')}} as o
  USING(order_id)
  LEFT JOIN
    {{ref('stg_localbike_dataset__stores')}} as s
  USING(store_id)
  GROUP BY 
    s.state,
    oi.product_id
  QUALIFY
    rn = 1
)

SELECT
  c.product_id,
  c.distinct_customer_count,
  c.staff_id,
  d.state
FROM
  customer_counts_per_product as c
LEFT JOIN
  dominant_state_per_product as d
ON
  c.product_id = d.product_id
ORDER BY
  distinct_customer_count DESC
