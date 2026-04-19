CREATE TABLE orders (
    order_id TEXT PRIMARY KEY,
    order_status TEXT,
    customer_id TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE customers (
    customer_id TEXT PRIMARY KEY,
    customer_unique_id TEXT,
    customer_zip_code_prefix INT,
    customer_city TEXT,
    customer_state TEXT
);

CREATE TABLE order_items (
    order_id TEXT,
    order_item_id INT,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TIMESTAMP,
    price FLOAT,
    freight_value FLOAT
);

CREATE TABLE order_payments (
    order_id TEXT,
    payment_sequential INT,
    payment_type TEXT,
    payment_installments INT,
    payment_value FLOAT
);

CREATE TABLE product (
    product_id TEXT PRIMARY KEY,
    product_category_name TEXT
);

CREATE TABLE seller (
    seller_id TEXT PRIMARY KEY,
    seller_city TEXT,
    seller_state TEXT
);

CREATE TABLE order_review (
    review_id TEXT,
    order_id TEXT,
    review_score INT
);
