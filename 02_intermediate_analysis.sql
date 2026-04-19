SELECT o.customer_id, SUM(oi.price) AS total_spent
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 10;

SELECT product_id, COUNT(*) AS units_sold
FROM order_items
GROUP BY product_id
ORDER BY units_sold DESC
LIMIT 10;

SELECT p.product_category_name, SUM(oi.price) AS total_revenue
FROM product p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;



SELECT p.product_category_name, AVG(orv.review_score::FLOAT) AS avg_review
FROM product p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN order_review orv ON oi.order_id = orv.order_id
GROUP BY p.product_category_name
ORDER BY avg_review DESC;

SELECT c.customer_state, SUM(oi.freight_value) AS total_freight
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_freight DESC;

SELECT COUNT(*) AS late_deliveries
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_date;