-- Orders by customer state

SELECT
    c.customer_state,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;






-- Repeat customer analysis

SELECT
    COUNT(*) FILTER (WHERE order_count = 1) AS one_time_customers,
    COUNT(*) FILTER (WHERE order_count > 1) AS repeat_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) AS customer_orders;

-- Repeat customer rate

SELECT
    ROUND(
        COUNT(*) FILTER (WHERE order_count > 1) * 100.0
        / COUNT(*),
        2
    ) AS repeat_customer_rate
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) AS customer_orders;



-- Average orders per customer

SELECT
    ROUND(AVG(order_count), 2) AS average_orders_per_customer
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) AS customer_orders;



-- Average customer spending

SELECT
    ROUND(AVG(customer_spending), 2) AS average_customer_spending
FROM (
    SELECT
        c.customer_unique_id,
        SUM(p.payment_value) AS customer_spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN payments p
        ON o.order_id = p.order_id
    GROUP BY c.customer_unique_id
) AS customer_values;



-- Customer value by state

SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value), 2) AS total_customer_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY total_customer_value DESC
LIMIT 10;