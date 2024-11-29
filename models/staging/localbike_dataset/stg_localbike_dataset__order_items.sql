SELECT
    order_id,
    product_id,
    item_id,
    CONCAT(order_id,"_",product_id) as order_product_id,
    quantity,
    list_price,
    discount,
    ((quantity * list_price) -  (quantity * list_price * discount)) as order_price_discounted
FROM   
    {{source('localbike_dataset', 'order_items')}}
