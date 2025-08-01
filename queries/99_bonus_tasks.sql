CREATE PROCEDURE GetCustomerLifetimeValue AS  

BEGIN  

SELECT C.customer_id, C.name, C.email, SUM(O.total_amount) AS Lifetime_Value  

FROM CUSTOMERS C  

JOIN ORDERS O ON C.customer_id = O.customer_id GROUP BY C.customer_id, C.name, C.email;  

END; 