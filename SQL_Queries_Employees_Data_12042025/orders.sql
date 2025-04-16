-- Create orders table and analyze it.

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product VARCHAR(50),
    quantity INT,
    price INT
);

INSERT INTO orders (order_id, customer_name, product, quantity, price)
VALUES
(1, 'John Doe', 'Laptop', 1, 50000),
(2, 'Jane Smith', 'Phone', 2, 20000),
(3, 'John Doe', 'Laptop', 1, 52000),
(4, 'Emily Davis', 'Tablet', 1, 15000),
(5, 'Jane Smith', 'Phone', 3, 21000);

-- Get the total quantity of products ordered by each customer.

SELECT
	orders.customer_name as Customer_Name,
    sum(orders.quantity) as Ordered_Products
FROM
	employees.orders
GROUP BY
	Customer_Name;
    
-- Only include orders where each individual order’s price is greater than 15000.

SELECT
	orders.customer_name as Customer_Name,
    sum(orders.quantity) as Ordered_Products
FROM
	employees.orders
WHERE orders.price > 15000
GROUP BY
	Customer_Name;

-- And only include customers whose total quantity ordered is greater than 2.
SELECT
	orders.customer_name as Customer_Name,
    sum(orders.quantity) as Ordered_Products
FROM
	employees.orders
WHERE orders.price > 15000
GROUP BY
	Customer_Name
HAVING
	Ordered_Products > 2;
