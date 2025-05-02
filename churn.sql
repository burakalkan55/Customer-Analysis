SELECT 
  customerid,
  CASE 
    WHEN DATE '2011-12-10' - MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI'))::date <= 30 THEN 'Active'
    WHEN DATE '2011-12-10' - MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI'))::date <= 90 THEN 'At Risk'
    ELSE 'Churned'
  END AS churn_status
FROM customers
WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
GROUP BY customerid;



SELECT 
  churn_status,
  COUNT(*) AS customer_count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM (
  SELECT 
    customerid,
    CASE 
      WHEN DATE '2011-12-10' - MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI'))::date <= 30 THEN 'Active'
      WHEN DATE '2011-12-10' - MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI'))::date <= 90 THEN 'At Risk'
      ELSE 'Churned'
    END AS churn_status
  FROM customers
  WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
  GROUP BY customerid
) AS churned_customers
GROUP BY churn_status
ORDER BY percentage DESC;
