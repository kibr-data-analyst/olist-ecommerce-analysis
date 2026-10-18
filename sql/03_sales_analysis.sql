-- Sales by product category

SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC;


-- Monthly sales trend

SELECT
    TO_CHAR(o.order_purchase_timestamp::timestamp, 'YYYY-MM') AS month,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;



-- Monthly sales trend

SELECT
    TO_CHAR(o.order_purchase_timestamp::timestamp, 'YYYY-MM') AS month,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;









-- Freight value analysis

SELECT
    ROUND(SUM(freight_value), 2) AS total_freight_value,
    ROUND(AVG(freight_value), 2) AS average_freight_value
FROM order_items;



-- Average freight per order

SELECT
    ROUND(SUM(freight_value) / COUNT(DISTINCT order_id), 2) AS average_freight_per_order
FROM order_items;








-- Top 10 product categories

SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY total_sales DESC
LIMIT 10;