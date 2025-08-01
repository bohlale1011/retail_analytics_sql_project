
--T op 5 best-selling products per category

WITH RankedProducts AS (
    SELECT 
        P.category,
        P.name,
        SUM(OI.quantity) AS total_quantity,
        RANK() OVER (PARTITION BY P.category ORDER BY SUM(OI.quantity) DESC) AS rank
    FROM 
        ORDER_ITEMS OI
    JOIN 
        PRODUCTS P ON OI.product_id = P.product_id
    GROUP BY 
        P.category, P.name
)
SELECT 
    category, 
    name,
    total_quantity
FROM 
    RankedProducts
WHERE 
    rank <= 5;
	
	
--Products with high stock but poor sales

SELECT 
    P.product_id,
    P.name,
    P.category,
    P.stock_quantity,
    ISNULL(SUM(OI.quantity), 0) AS total_sold
FROM 
    PRODUCTS P
LEFT JOIN 
    ORDER_ITEMS OI ON P.product_id = OI.product_id
GROUP BY 
    P.product_id, P.name, P.category, P.stock_quantity
HAVING 
    ISNULL(SUM(OI.quantity), 0) < 10 AND P.stock_quantity > 100
ORDER BY 
    P.stock_quantity DESC;
	