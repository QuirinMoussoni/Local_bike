SELECT
    order_id,
    customer_id,
    order_status,
    order_date as order_created_at,
    required_date as order_required_at,
    COALESCE(shipped_date, "Not maintained") as order_shipped_at,
    store_id,
    staff_id
FROM 
    {{source('localbike_dataset', 'orders')}}
