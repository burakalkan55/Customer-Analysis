SELECT 
  COUNT(*) AS total_records,
  COUNT(DISTINCT invoiceno) AS unique_invoices,
  COUNT(DISTINCT customerid) AS unique_customers,
  COUNT(DISTINCT stockcode) AS unique_products
FROM customers;

SELECT COUNT(*) AS null_customerid_count
FROM customers
WHERE customerid IS NULL;

SELECT 
  ROUND(SUM(quantity * unitprice), 2) AS total_revenue
FROM customers
WHERE quantity > 0 AND unitprice > 0;


SELECT 
  country,
  ROUND(SUM(quantity * unitprice), 2) AS revenue,
  COUNT(DISTINCT customerid) AS total_customers
FROM customers
WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
GROUP BY country
ORDER BY revenue DESC;


SELECT 
  customerid,
  ROUND(SUM(quantity * unitprice), 2) AS total_spent
FROM customers
WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
GROUP BY customerid
ORDER BY total_spent DESC;
