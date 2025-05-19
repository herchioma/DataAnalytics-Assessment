# DataAnalytics-Assessment

This project involved working with real-world customer financial data to answer four core business questions using SQL. The goal was to demonstrate strong analytical thinking, writing efficient queries, and handling common data challenges all while maintaining clear documentation of my workflow.


## Data Exploration & Understanding

Before writing any queries, I spent time exploring the dataset to understand its structure and relationships. The data was spread across multiple tables representing users, savings accounts, investment plans, and transactions. 

One early challenge was figuring out how savings and investments were represented since both were stored in the same plans table but differentiated by boolean flags. Understanding the meaning and business context of columns like `confirmed_amount`, `is_regular_savings`, and `is_a_fund` was crucial. I addressed this by running targeted sample queries and verifying assumptions with logical checks, which helped clarify how to accurately filter and categorize the data.


## Query Development

### Q1: Identifying Customers with Both Savings and Investments

- **Approach:**  
  I joined user data with savings and investment plans, focusing only on confirmed deposits (`confirmed_amount > 0`). The goal was to find users who actively fund both product types, then rank them by total deposit volume.

- **Challenge:**  
  Query performance was a problem because the dataset was large, causing timeouts during testing.

- **Resolution:**  
  To overcome this, I temporarily limited the dataset to the first 100 users during development. This reduced processing time and made iterative testing manageable without altering the core logic. For production, I would recommend indexing strategies or batching.

### Q2: Transaction Frequency Categorization

- **Approach:**  
  I calculated each user’s total inbound transactions and the number of active months between their first and last transaction. Based on the average transactions per month, users were grouped into high, medium, or low frequency categories.

- **Challenge:**  
  Some users had activity spans less than a full month, which caused division-by-zero errors in calculating average transaction frequency.

- **Resolution:**  
  I used the SQL function `GREATEST(..., 1)` to ensure the active duration was always at least one month. This small but critical adjustment prevented errors and ensured consistent, reliable categorization.

### Q3: Detecting Inactive Accounts

- **Approach:**  
  This query flagged savings and investment plans without any confirmed inflow over the past year. I calculated inactivity by checking the days since the last transaction and used a `CASE` statement to clearly label plan types.

- **Challenges:**  
  1. Differentiating between savings and investment plans in a shared table was initially confusing.  
  2. Some plans had never received any transactions, resulting in `NULL` dates, complicating inactivity detection.

- **Resolutions:**  
  I explicitly labeled each plan type using their respective boolean flags with a `CASE` expression. To handle plans without transactions, I accounted for `NULL` last transaction dates in the query’s filtering logic, ensuring inactive but valid plans were included.

### Q4: Estimating Customer Lifetime Value (CLV)

- **Approach:**  
  I calculated CLV by annualizing each customer’s transaction rate and multiplying by an estimated average profit per transaction (assumed at 0.1%). The query took into account the tenure of each customer since account creation.

- **Challenge:**  
  New customers with less than one month of tenure caused division-by-zero errors in the calculation.

- **Resolution:**  
  Again, I applied `GREATEST(..., 1)` to guarantee the tenure was at least one month, ensuring stability and accuracy in the CLV estimation for all customers.


## Testing and Optimization

I tested each query against subsets of data to verify accuracy and debug edge cases, such as customers with no transactions or very recent sign-ups. Performance optimizations like limiting datasets during development and using functions to prevent errors were essential to keep queries efficient and reliable.
