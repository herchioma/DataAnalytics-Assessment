-- Q2: Transaction Frequency Analysis
-- Categorize customers based on their average monthly transaction volume.
-- Use GREATEST to avoid division by zero when duration is less than 1 month
SELECT 
    CASE
        WHEN COUNT(s.id) / TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) >= 10 THEN 'High Frequency'
        WHEN COUNT(s.id) / TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(u.id) AS customer_count,
    ROUND(COUNT(s.id) / TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)), 2) AS avg_transaction_per_month
FROM users_customuser u
JOIN savings_savingsaccount s ON u.id = s.owner_id;

