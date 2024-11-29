SELECT
    store_id,
    store_name,
    phone as phone_number,
    email,
    street,
    city,
    state,
    zip_code
FROM
    {{source('localbike_dataset', 'stores')}}
