SELECT COUNT(*) AS total_orders
FROM orders;

SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customers;

SELECT SUM(price) AS total_revenue
FROM order_items;

SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


SELECT customer_state, COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;

SELECT 
    SUM(price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM order_items;

SELECT SUM(payment_value) AS total_payments
FROM payments;

SELECT AVG(review_score::FLOAT) AS avg_review_score
FROM order_review;

