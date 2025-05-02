SELECT country,
         COUNT(DISTINCT customerid) AS unique_customers,
         ROUND(SUM(quantity * unitprice)::numeric, 2) AS total_revenue

FROM customers
WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
GROUP BY country
ORDER BY total_revenue DESC;