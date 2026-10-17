-- Order status analysis

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Delivery rate

SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE order_status = 'delivered') AS delivered_orders,
    ROUND(
        COUNT(*) FILTER (WHERE order_status = 'delivered') * 100.0
        / COUNT(*),
        2
    ) AS delivery_rate
FROM orders;


-- Total product sales

SELECT
    ROUND(SUM(price), 2) AS total_sales
FROM order_items;