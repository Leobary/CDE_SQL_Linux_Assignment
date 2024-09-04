-- Questions posed from the sales of good and services offered by POSEY

-- Question 1
/* Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id
field in the resulting table */

-- Solution
SELECT id FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

-- Question 2
/* Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or
poster_qty is over 1000 */

-- Solution
SELECT * FROM orders
WHERE standard_qty = 0 
AND (gloss_qty > 1000 OR poster_qty > 1000);

-- Question 3
/* Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or
'Ana', but it doesn't contain 'eana' */

-- Solution
SELECT * FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
AND (primary_poc LIKE 'Ana%' OR primary_poc LIKE '%ana%')
AND (primary_poc NOT LIKE '%eana%');

-- Question 4
/* Provide a table that provides the region for each sales_rep along with their associated accounts. Your
final table should include three columns: the region name, the sales rep name, and the account name. Sort
the accounts alphabetically (A-Z) according to account name */

-- Solution
SELECT  TRIM(r.name) region_name, TRIM(s.name) sales_rep_name, TRIM(a.name) account_name
FROM accounts a 
LEFT JOIN sales_reps s ON s.id = a.sales_rep_id
LEFT JOIN region r ON r.id = s.region_id
ORDER BY 3 ASC;


