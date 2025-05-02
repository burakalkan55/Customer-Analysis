SELECT column_name
FROM information_schema.columns
WHERE table_name = 'customers';


SELECT 
    description,
    SUM(quantity) AS total_sold
FROM customers
WHERE quantity > 0 AND unitprice > 0
GROUP BY description
ORDER BY total_sold DESC
LIMIT 5;
