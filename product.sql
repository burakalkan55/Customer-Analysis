SELECT 
  description,
  SUM(quantity) AS total_sold
FROM customers
WHERE quantity > 0 AND unitprice > 0
GROUP BY description
ORDER BY total_sold DESC
LIMIT 10;


SELECT 
  description,
  ROUND(SUM(quantity * unitprice)::numeric, 0) AS total_revenue
FROM customers
WHERE quantity > 0 AND unitprice > 0
GROUP BY description
ORDER BY total_revenue DESC
LIMIT 10;
