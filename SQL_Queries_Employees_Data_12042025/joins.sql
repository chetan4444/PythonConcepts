CREATE TABLE customer_Id
(
cus_id int,
first_name varchar(255),
last_name varchar(255)
);

CREATE TABLE transaction_Id
(
cus_id int,
amount int,
transaction_id int
);

INSERT INTO customer_id (cus_id, first_name, last_name)
Values 
(123, 'chetan', 'kumar'),
(124, 'Ram', 'Ji'),
(125, 'Shyam', 'Ji'),
(126, 'Pandav', 'Priya');

INSERT INTO transaction_id (cus_id, amount, transaction_id)
Values
(123, 2300, 9876),
(129, 7000, 8769),
(124, 9000, 6579),
(128, 800, 7654)
;

SELECT
	*
FROM customer_id c JOIN transaction_id t ON c.cus_id = t.cus_id;

SELECT
	*
FROM customer_id c INNER JOIN transaction_id t ON c.cus_id = t.cus_id;

SELECT
	*
FROM customer_id c LEFT JOIN transaction_id t ON c.cus_id = t.cus_id;

SELECT
	*
FROM customer_id c RIGHT JOIN transaction_id t ON c.cus_id = t.cus_id;

SELECT
	*
FROM customer_id c LEFT OUTER JOIN transaction_id t ON c.cus_id = t.cus_id;

SELECT
	*
FROM customer_id c RIGHT OUTER JOIN transaction_id t ON c.cus_id = t.cus_id;

-- JOIN is same as INNER JOIN
-- Right outer join is same as right join
-- Left Outer Join is same as Left Join

SELECT
	*
FROM customer_id c LEFT JOIN transaction_id t ON c.cus_id = t.cus_id;

SELECT
	*
FROM customer_id c LEFT JOIN transaction_id t ON c.cus_id = t.cus_id
WHERE
	t.cus_id IS NULL;
    

SELECT
	*
FROM customer_id c RIGHT JOIN transaction_id t ON c.cus_id = t.cus_id
WHERE
	c.cus_id IS NULL;