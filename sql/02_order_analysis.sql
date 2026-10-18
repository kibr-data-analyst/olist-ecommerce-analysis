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



-- Average delivery time

SELECT
    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (
                    order_delivered_customer_date
                    - order_purchase_timestamp
                )
            ) / 86400
        ),
        2
    ) AS average_delivery_days
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL;


  -- Cancellation rate

SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE order_status = 'canceled') AS canceled_orders,
    ROUND(
        COUNT(*) FILTER (WHERE order_status = 'canceled') * 100.0
        / COUNT(*),
        2
    ) AS cancellation_rate
FROM orders;