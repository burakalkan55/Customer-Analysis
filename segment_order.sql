SELECT 
  churn_status,
  ROUND(AVG(total_spent)::numeric, 2) AS avg_spending,
  COUNT(*) AS customer_count
FROM (
  SELECT 
    customerid,
    SUM(quantity * unitprice) AS total_spent,
    CASE 
      WHEN DATE '2011-12-10' - MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI'))::date <= 30 THEN 'Active'
      WHEN DATE '2011-12-10' - MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI'))::date <= 90 THEN 'At Risk'
      ELSE 'Churned'
    END AS churn_status
  FROM customers
  WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
  GROUP BY customerid
) AS churned_data
GROUP BY churn_status
ORDER BY avg_spending DESC;




SELECT 
  churn_status,
  country,
  COUNT(DISTINCT customerid) AS customer_count
FROM (
  SELECT 
    customerid,
    country,
    MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI')) AS last_order_date,
    CASE 
      WHEN DATE '2011-12-10' - MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI'))::date <= 30 THEN 'Active'
      WHEN DATE '2011-12-10' - MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI'))::date <= 90 THEN 'At Risk'
      ELSE 'Churned'
    END AS churn_status
  FROM customers
  WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
  GROUP BY customerid, country
) AS churned_by_country
GROUP BY churn_status, country
ORDER BY churn_status, customer_count DESC;




SELECT 
  churn_status,
  ROUND(AVG(order_count), 2) AS avg_order_count
FROM (
  SELECT 
    customerid,
    COUNT(DISTINCT invoiceno) AS order_count,
    CASE 
      WHEN DATE '2011-12-10' - MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI'))::date <= 30 THEN 'Active'
      WHEN DATE '2011-12-10' - MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI'))::date <= 90 THEN 'At Risk'
      ELSE 'Churned'
    END AS churn_status
  FROM customers
  WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
  GROUP BY customerid
) AS churn_freq
GROUP BY churn_status
ORDER BY avg_order_count DESC;
