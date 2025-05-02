SELECT 
  customerid AS customer_id,
  COUNT(DISTINCT stockcode) AS unique_products,
  ROUND(SUM(quantity * unitprice)::numeric, 0) AS total_spent
FROM customers
WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
GROUP BY customerid
ORDER BY total_spent DESC
LIMIT 10;
