-- Data Cleaning & Validation
-- Dataset: Olist E-commerce
-- Purpose: Handle nulls, duplicates, and ensure data consistency

--------------------------------------------------
-- 1. CHECK FOR NULL VALUES
--------------------------------------------------

SELECT * FROM orders WHERE order_id IS NULL;
SELECT * FROM customers WHERE customer_id IS NULL;
SELECT * FROM order_items WHERE order_id IS NULL;
SELECT * FROM order_payments WHERE order_id IS NULL;
SELECT * FROM order_review WHERE review_id IS NULL;

--------------------------------------------------
-- 2. REMOVE DUPLICATES (if any)
--------------------------------------------------

-- Orders (order_id should be unique)
DELETE FROM orders
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM orders
    GROUP BY order_id
);

-- Customers
DELETE FROM customers
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM customers
    GROUP BY customer_id
);

--------------------------------------------------
-- 3. HANDLE MISSING VALUES
--------------------------------------------------

-- Replace empty strings with NULL (important for timestamps)
UPDATE orders
SET order_delivered_customer_date = NULL
WHERE order_delivered_customer_date = '';

UPDATE orders
SET order_approved_at = NULL
WHERE order_approved_at = '';

--------------------------------------------------
-- 4. VALIDATE NUMERIC VALUES
--------------------------------------------------

-- Check for negative or zero price
SELECT * FROM order_items WHERE price <= 0;

-- Check for negative freight values
SELECT * FROM order_items WHERE freight_value < 0;

--------------------------------------------------
-- 5. VALIDATE DATE CONSISTENCY
--------------------------------------------------

-- Delivered before purchase (should not happen)
SELECT *
FROM orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

-- Estimated date before purchase (invalid case)
SELECT *
FROM orders
WHERE order_estimated_delivery_date < order_purchase_timestamp;

--------------------------------------------------
-- 6. CHECK REFERENTIAL INTEGRITY
--------------------------------------------------

-- Orders with missing customers
SELECT *
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Order items without matching orders
SELECT *
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

--------------------------------------------------
-- 7. REVIEW SCORE VALIDATION
--------------------------------------------------

-- Check invalid review scores
SELECT *
FROM order_review
WHERE review_score < 1 OR review_score > 5;
