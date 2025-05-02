CREATE OR REPLACE VIEW customer_first_order AS
SELECT 
  customerid,
  MIN(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI')) AS first_order_date
FROM customers
WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
GROUP BY customerid;



SELECT 
  DATE_TRUNC('month', cfo.first_order_date) AS cohort_month,
  DATE_TRUNC('month', TO_TIMESTAMP(c.invoicedate, 'MM/DD/YYYY HH24:MI')) AS order_month,
  COUNT(DISTINCT c.customerid) AS customers,
  ROUND(SUM(c.quantity * c.unitprice)::numeric, 2) AS revenue
FROM customer_first_order cfo
JOIN customers c ON c.customerid = cfo.customerid
WHERE c.quantity > 0 AND c.unitprice > 0
GROUP BY cohort_month, order_month
ORDER BY cohort_month, order_month;
