
--Monthly revenue trend over the past year

SELECT 
    FORMAT(order_date, 'yyyy-MM') AS [Month],
    SUM(total_amount) AS Monthly_Revenue
FROM 
    ORDERS
WHERE 
    order_date >= DATEADD(YEAR, -1, GETDATE())
GROUP BY 
    FORMAT(order_date, 'yyyy-MM')
ORDER BY 
    [Month];
	
	
--Product categories that generate the most revenue

SELECT 
    P.category,
    SUM(OI.quantity * OI.price) AS Total_Revenue
FROM 
    ORDER_ITEMS OI
JOIN 
    PRODUCTS P ON OI.product_id = P.product_id
GROUP BY 
    P.category
ORDER BY 
    Total_Revenue DESC;
	
	
