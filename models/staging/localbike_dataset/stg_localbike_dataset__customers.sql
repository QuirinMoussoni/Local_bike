SELECT
    customer_id,
    first_name, 
    last_name,
    COALESCE(phone, 'Not maintained') as phone_number,
    email,
    street,
    city,
    state,
    zip_code
FROM 
    {{source('localbike_dataset', 'customers')}}
