SELECT 
  COUNT(*) AS total_records,                              -- Toplam satır sayısı
  COUNT(DISTINCT customerid) AS unique_customers,         -- Farklı müşteri sayısı
  COUNT(DISTINCT stockcode) AS unique_products,           -- Farklı ürün kodu sayısı
  SUM(quantity) AS total_sales_volume                     -- Satılan toplam ürün adedi
FROM customers
WHERE quantity > 0 AND unitprice > 0;


SELECT
    description,
    SUM(quantity) AS total_sold
FROM customers
WHERE quantity > 0 AND unitprice > 0
GROUP BY description
ORDER BY total_sold DESC
LIMIT 5;