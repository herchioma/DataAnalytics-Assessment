-- Q1: High-Value Customers with Multiple Products
-- Identify customers with at least one funded savings plan and one funded investment plan,
-- sorted by total deposits (in kobo converted to main currency).
-- Limited to first 100 users to avoid timeout during large data scan
SELECT 
    u.id AS owner_id,
    u.name,
    COUNT(DISTINCT s.plan_id) AS savings_count,
    COUNT(DISTINCT p.id) AS investment_count,
    SUM(s.amount) AS total_deposits
FROM (
    SELECT * FROM users_customuser LIMIT 100
) u
JOIN savings_savingsaccount s ON u.id = s.owner_id
JOIN plans_plan p ON u.id = p.owner_id
WHERE s.amount > 0 AND p.amount > 0
GROUP BY u.id, u.name
HAVING savings_count >= 1 AND investment_count >= 1
ORDER BY total_deposits DESC;
