SELECT 
  description AS product,
  COUNT(DISTINCT customerid) AS unique_customers,
  ROUND(SUM(quantity * unitprice)::numeric, 0) AS total_revenue,
  ROUND((SUM(quantity * unitprice) / COUNT(DISTINCT customerid))::numeric, 2) AS avg_spend_per_customer
FROM customers
WHERE quantity > 0 AND unitprice > 0 AND customerid IS NOT NULL
GROUP BY description
ORDER BY avg_spend_per_customer DESC
LIMIT 10;




/*
customers tablosundan:

Her ürün (description) için

Kaç farklı müşteri satın almış

Üründen toplam ne kadar gelir elde edilmiş

Ve müşteri başına ortalama harcama hesapla   */
