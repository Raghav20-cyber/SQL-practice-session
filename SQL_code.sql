-- Create Customers Table
DROP TABLE IF EXISTS o;
DROP TABLE IF EXISTS c;

CREATE TABLE c (
    customer_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

-- Insert Data
INSERT INTO c (customer_id, name, city) VALUES
('C1', 'Raghav', 'Delhi'),
('C2', 'Aman', 'Mumbai'),
('C3', 'Neha', 'Pune'),
('C4', 'Simran', 'Delhi');

-- Create Orders Table
CREATE TABLE o (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    order_date DATE,
    amount INT,
    FOREIGN KEY (customer_id) REFERENCES c(customer_id)
);

-- Insert Data
INSERT INTO o (order_id, customer_id, order_date, amount) VALUES
('O1', 'C1', '2025-01-10', 200),
('O2', 'C2', '2025-01-12', 500),
('O3', 'C1', '2025-02-01', 700),
('O4', 'C3', '2025-02-05', 300),
('O5', 'C1', '2025-02-10', 400);

-- Q1. Show total revenue generated.

-- Q2. Find total number of orders per customer.

-- Q3. Which customer generated the highest revenue?

-- Q4. Find customers who placed more than 1 order.

-- Q5. Find total revenue generated per city.

-- Q6. Which month generated the highest revenue?
-- (Hint: Extract month from order_date)

-- Q7. Find customers who never placed an order.

-- Q8. Find the second highest spending customer.

-- Q9. For each customer show:
--     - total_orders
--     - total_revenue
--     - average_order_value


SELECT SUM(amount) AS total_revenue
FROM o;

SELECT customer_id, COUNT(*) AS Total_orders
FROM o
GROUP BY customer_id;

SELECT customer_id, SUM(amount) AS revenue_generated
FROM o
GROUP BY customer_id
ORDER BY revenue_generated DESC
LIMIT 1;

SELECT customer_id, COUNT(*) AS order_placed
FROM o
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT a.city,
       SUM(p.amount) AS total_revenue
FROM c a
JOIN o p 
ON a.customer_id = p.customer_id
GROUP BY a.city;

SELECT 
    strftime('%Y-%m', order_date) AS month,
    SUM(amount) AS monthly_revenue
FROM o
GROUP BY strftime('%Y-%m', order_date)
ORDER BY monthly_revenue DESC
LIMIT 1;

SELECT a.customer_id,
       COUNT(p.order_id) AS orders
FROM c a
LEFT JOIN o p 
ON a.customer_id = p.customer_id
GROUP BY a.customer_id
HAVING COUNT(p.order_id) = 0;


SELECT customer_id, SUM(amount)
AS second_highest_revenue
FROM o
GROUP BY customer_id
ORDER BY second_highest_revenue DESC
LIMIT 1 OFFSET 1;

SELECT customer_id,
SUM(amount) AS total_revenue,
COUNT(*) AS total_orders,
ROUND(AVG(amount), 2) AS average_order_value
FROM o
GROUP BY customer_id
