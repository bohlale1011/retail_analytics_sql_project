
--Orders where total_amount doesn’t match sum of items

SELECT 
    O.order_id,
    O.total_amount,
    SUM(OI.quantity * OI.price) AS calculated_total
FROM 
    ORDERS O
JOIN 
    ORDER_ITEMS OI ON O.order_id = OI.order_id
GROUP BY 
    O.order_id, O.total_amount
HAVING 
    ROUND(SUM(OI.quantity * OI.price), 2) != ROUND(O.total_amount, 2);
	
	
--Duplicate emails in the customer table

SELECT 
    email,
    COUNT(*) AS duplicate_count
FROM 
    CUSTOMERS
GROUP BY 
    email
HAVING 
    COUNT(*) > 1;