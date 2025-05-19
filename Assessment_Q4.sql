-- Q4: Customer Lifetime Value (CLV) Estimation
-- Estimate CLV using: (total_txns / tenure_months) * 12 * avg_profit_per_txn,
-- where profit per transaction = 0.1% of transaction value.
-- Use GREATEST to ensure no division by zero in tenure calculation
SELECT 
    u.id AS customer_id,
    u.name,
    TIMESTAMPDIFF(MONTH, u.date_joined, NOW()) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    ROUND((COUNT(s.id) / TIMESTAMPDIFF(MONTH, u.date_joined, NOW())) * 12 * AVG(0.001 * s.amount), 2) AS estimated_clv
FROM users_customuser AS u
JOIN savings_savingsaccount AS s ON u.id = s.owner_id
GROUP BY u.id, u.name
ORDER BY estimated_clv DESC;
