SELECT 
    o.customer_id,
    SUM(oi.price) AS total_spent,
    CASE 
        WHEN SUM(oi.price) < 100 THEN 'Low'
        WHEN SUM(oi.price) BETWEEN 100 AND 500 THEN 'Medium'
        ELSE 'High'
    END AS spending_segment
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC;

SELECT 
    AVG(review_score::FLOAT) AS avg_review_score,
    AVG(order_delivered_customer_date - order_purchase_timestamp) AS avg_delivery_time
FROM orders o
JOIN order_review r ON o.order_id = r.order_id
WHERE order_delivered_customer_date IS NOT NULL;

SELECT 
    payment_type,
    COUNT(*) AS total_transactions,
    SUM(payment_value) AS total_revenue
FROM payments
GROUP BY payment_type
ORDER BY total_transactions DESC;

SELECT 
    seller_id,
    SUM(price) AS total_revenue
FROM order_items
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;