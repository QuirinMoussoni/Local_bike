SELECT
    staff_id,
    first_name,
    last_name,
    email,
    phone as phone_number,
    active as staff_status,
    store_id,
    COALESCE(manager_id, 'Not maintained') as manager_id
FROM
    {{source('localbike_dataset', 'staffs')}}
