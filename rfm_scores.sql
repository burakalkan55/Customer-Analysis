CREATE OR REPLACE VIEW rfm_base AS
SELECT 
  customerid,
  DATE '2011-12-10' - MAX(TO_TIMESTAMP(invoicedate, 'MM/DD/YYYY HH24:MI'))::date AS recency,
  COUNT(DISTINCT invoiceno) AS frequency,
  ROUND(SUM(quantity * unitprice)::numeric, 2) AS monetary
FROM customers
WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
GROUP BY customerid;


SELECT 
  customerid,
  recency,
  frequency,
  monetary,
  NTILE(5) OVER (ORDER BY recency DESC) AS recency_score,
  NTILE(5) OVER (ORDER BY frequency) AS frequency_score,
  NTILE(5) OVER (ORDER BY monetary) AS monetary_score
FROM rfm_base;


