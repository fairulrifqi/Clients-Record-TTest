-- Preview: Show first 10 rows from transactions_data table
SELECT * 
FROM transactions_data
LIMIT 10;

-- Preview: Show first 10 rows from users_data table
SELECT * 
FROM users_data
LIMIT 10;

-- Preview: Show first 10 rows from cards_data table
SELECT * 
FROM cards_data
LIMIT 10;

-- Calculate total absolute transaction amount per client
SELECT 
	client_id, 
	SUM(ABS(CAST(REPLACE(REPLACE(amount, '$', ''), ',', '') AS FLOAT))) AS total_amount
FROM transactions_data
GROUP BY client_id
ORDER BY total_amount DESC
LIMIT 10;

-- Count number of transactions by merchant city
SELECT 
	merchant_city, 
	COUNT(id) AS number_of_transactions
FROM transactions_data
GROUP BY merchant_city
ORDER BY number_of_transactions DESC
LIMIT 20;

-- Summarize transaction metrics grouped by merchant state
SELECT 
	merchant_state, 
	SUM(CAST(REPLACE(REPLACE(amount, '$', ''), ',', '') AS FLOAT)) AS total_amount_received,
	COUNT(id) AS total_transactions,
	COUNT(DISTINCT merchant_id) AS total_merchant,
	COUNT(DISTINCT client_id) AS total_client
FROM transactions_data
GROUP BY merchant_state;

-- Aggregate total cards and credit limits per client
SELECT 
	client_id, 
	COUNT(id) AS total_card_owned,
	SUM(CAST(REPLACE(REPLACE(credit_limit, '$', ''), ',', '') AS FLOAT)) AS maximum_loan_amount
FROM cards_data
GROUP BY client_id
ORDER BY total_card_owned DESC, maximum_loan_amount DESC;

-- Count number of cards opened per month
WITH account_open_cte AS (
	SELECT 
		card_number,
		STR_TO_DATE(CONCAT('01/', acct_open_date), '%d/%m/%Y') AS account_open
	FROM cards_data
)
SELECT 
	MONTH(cte.account_open) AS open_month,
	COUNT(c.card_number) AS total_cards_opened
FROM account_open_cte AS cte
JOIN cards_data AS c ON cte.card_number = c.card_number
GROUP BY open_month
ORDER BY total_cards_opened DESC;

-- Find earliest card open date per client
SELECT 
	client_id, 
	MIN(acct_open_date) AS first_account_open_date
FROM cards_data
GROUP BY client_id;

-- Select users whose yearly income is less than their total debt
SELECT
	id, 
	yearly_income, 
	total_debt 
FROM users_data
WHERE yearly_income < total_debt;

-- Select users with credit score above average
SELECT
	id, 
	credit_score
FROM users_data
WHERE credit_score > (
	SELECT AVG(credit_score) FROM users_data
);

-- Aggregate transaction and card info per client
SELECT
	u.id AS client_id,
	COUNT(t.id) AS total_transactions,
	SUM(CAST(REPLACE(REPLACE(t.amount, '$', ''), ',', '') AS FLOAT)) AS total_amount,
	AVG(CAST(REPLACE(REPLACE(t.amount, '$', ''), ',', '') AS FLOAT)) AS avg_transaction,
	MAX(c.card_brand) AS most_used_card,
	MAX(c.has_chip) AS has_chip_card,
	COUNT(DISTINCT c.id) AS num_cards,
	SUM(CAST(REPLACE(REPLACE(c.credit_limit, '$', ''), ',', '') AS FLOAT)) AS maximum_loan_amount,
	MAX(u.credit_score) AS credit_score,
	MAX(CAST(REPLACE(REPLACE(u.yearly_income, '$', ''), ',', '') AS FLOAT)) AS yearly_income,
	CASE
		WHEN MAX(u.credit_score) >= 650 THEN 'Low Risk'
		WHEN MAX(u.credit_score) < 650 THEN 'High Risk'
		ELSE 'Unknown'
	END AS risk_category
FROM transactions_data AS t
JOIN users_data AS u ON t.client_id = u.id
JOIN cards_data AS c ON t.card_id = c.id
GROUP BY u.id;