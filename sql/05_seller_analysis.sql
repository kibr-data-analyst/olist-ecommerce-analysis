-- Orders by seller

SELECT
    s.seller_state,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM order_items oi
JOIN sellers s
    ON oi.seller_id = s.seller_id
GROUP BY s.seller_state
ORDER BY total_orders DESC;