{% docs int_localbike_dataset__state %}

This model provides an aggregated view of state, combining data from multiple sources such as products, orders, order item and customer. It enriches the order data with the following metrics:
- **Total Distinct Customer**: The count of distinct customer in the order.
- **State**: Enriches the orders with State datas.  
- **Product**: Enriches the order with product-specific data, such as product name.
- **Staff Id**: Enriches the order with staff-specific data, such as name and manager id.

It provides a comprehensive view of each state, allowing for easy analysis of product performance.

{% enddocs %}
