SELECT p.sku, p.name, p.min_stock,
       COALESCE(SUM(s.qty),0) AS current_qty
FROM products p
LEFT JOIN stock s ON s.product_id = p.id
GROUP BY p.id
HAVING COALESCE(SUM(s.qty),0) < p.min_stock;
