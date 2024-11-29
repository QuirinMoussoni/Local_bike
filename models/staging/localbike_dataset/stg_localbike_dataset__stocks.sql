SELECT
    CONCAT(store_id,'_',product_id) as stocks_id,
    store_id,
    product_id,
    quantity
FROM   
    {{source('localbike_dataset', 'stocks')}}
