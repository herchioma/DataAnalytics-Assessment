-- Q3: Account Inactivity Alert
-- Flag savings or investment plans with no inflow in the last 365 days.
-- Categorize plan type and calculate days since last inflow
SELECT
  t.plan_id,
  t.owner_id,
  t.type,
  t.last_transaction_date,
  t.inactivity_days
FROM (
  SELECT
    p.id AS plan_id,
    p.owner_id,
    CASE
      WHEN p.is_regular_savings = 1 THEN 'Savings'
      WHEN p.is_a_fund          = 1 THEN 'Investment'
    END AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
  FROM plans_plan p
  LEFT JOIN savings_savingsaccount s
    ON s.plan_id = p.id
   AND s.confirmed_amount > 0      
  WHERE p.is_regular_savings = 1
     OR p.is_a_fund          = 1       
  GROUP BY
    p.id,
    p.owner_id,
    type
) AS t
WHERE
     t.last_transaction_date IS NULL 
  OR t.inactivity_days > 365          
ORDER BY
  t.inactivity_days DESC;
