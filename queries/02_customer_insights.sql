
--Top 10 customers by lifetime value

SELECT TOP 10 
    C.customer_id,
    C.name,
    C.email,
    SUM(O.total_amount) AS Lifetime_Value
FROM 
    CUSTOMERS C
JOIN 
    ORDERS O ON C.customer_id = O.customer_id
GROUP BY 
    C.customer_id, C.name, C.email
ORDER BY 
    Lifetime_Value DESC;
	
	
--Percentage of customers who made more than one order

SELECT 
    CAST(100.0 * COUNT(*) / (SELECT COUNT(*) FROM CUSTOMERS) AS DECIMAL(5,2)) AS Percentage_Multiple_Orders
FROM (
    SELECT 
        customer_id
    FROM 
        ORDERS
    GROUP BY 
        customer_id
    HAVING 
        COUNT(*) > 1
) AS MultiOrderCustomers;
