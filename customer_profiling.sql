----------------profiling customers allow us to understand their performance and behaviour.

CREATE TABLE customer_profiling AS 
SELECT
	CASE 
	WHEN age < 25 THEN 'Young'
	WHEN age >25 AND age <= 40 THEN 'Middle-aged'
	ELSE 'Senior'
	END AS age_segment,
	TRUNC(AVG(amount),2) as average_transaction,
	COUNT(*) as transaction_count
FROM customers
JOIN transactions ON customers.customer_id = transactions.customer_id
GROUP BY age_segment;

ALTER TABLE customer_profiling
ADD PRIMARY KEY (age_segment);


-------------listing active customers valuable to business

CREATE TABLE active_customers AS 
SELECT c.customer_id, first_name, last_name, SUM(amount) AS total_transactions_amount
FROM customers c
JOIN transactions t
ON c.customer_id= t.customer_id
GROUP BY c.customer_id
ORDER BY total_transactions_amount DESC;


ALTER TABLE active_customers
ADD PRIMARY KEY (customer_id);
