SELECT 
  customerid,
  ROUND(SUM(quantity * unitprice)::numeric, 2) AS total_spent,
  CASE
    WHEN SUM(quantity * unitprice) < 100 THEN 'Low'
    WHEN SUM(quantity * unitprice) < 500 THEN 'Medium'
    ELSE 'High'
  END AS segment
FROM customers
WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
GROUP BY customerid
ORDER BY total_spent DESC;


SELECT 
  customerid,
  MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI')) AS last_order_date,
  COUNT(DISTINCT invoiceno) AS frequency,
  ROUND(SUM(quantity * unitprice)::numeric, 2) AS monetary_value,
  CURRENT_DATE - MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI'))::date AS recency_days
FROM customers
WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
GROUP BY customerid
ORDER BY recency_days ASC;

SELECT DISTINCT customerid
FROM customers
WHERE TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI') >= CURRENT_DATE - INTERVAL '30 days'
  AND quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL;



SELECT 
  country,
  ROUND(SUM(quantity * unitprice)::numeric, 2) AS revenue,
  COUNT(DISTINCT customerid) AS total_customers
FROM customers
WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
GROUP BY country
ORDER BY revenue DESC;
