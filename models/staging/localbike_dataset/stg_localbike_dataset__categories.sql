SELECT
    category_id,
    category_name
FROM 
    {{source('localbike_dataset', 'categories')}}
