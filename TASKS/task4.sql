SELECT 
  description AS product,
  COUNT(DISTINCT customerid) AS unique_customers,
  SUM(quantity) AS total_quantity
FROM customers
WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
GROUP BY description
ORDER BY unique_customers DESC
LIMIT 10;
