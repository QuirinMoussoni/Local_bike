{% docs int_localbike_dataset__stores %}

This model provides an aggregated view of orders, combining data from multiple sources such as orders, order item and stores. It enriches the order data with the following metrics:
- **Total Order Discounted**: The count of distinct customer in the order.
- **Total Items**: Enriches the orders on the item level.  
- **Total Orders**: The count of orders. Enriches datas on the stores level.
- **Total Distinct Items**: The count of distinct item in the order.

It provides a comprehensive view of each store, allowing for easy analysis of orders performance.

{% enddocs %}
