# Sales Analysis Report Summary

---

##  Monthly Revenue Trend

We check how much money we made each month in the past year by summing the total order amounts for each month.

```sql
SELECT FORMAT(order_date, 'yyyy-MM') AS [Month],  
       SUM(total_amount) AS Monthly_Revenue
FROM ORDERS
WHERE order_date >= DATEADD(YEAR, -1, GETDATE())
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY [Month];
```

> This query groups orders by month and calculates monthly revenue using the `FORMAT` function.

---

##  Product Categories Revenue

We determine which product categories generated the most revenue by multiplying quantity sold by product price.

```sql
SELECT P.category, 
       SUM(OI.quantity * OI.price) AS Total_Revenue
FROM ORDER_ITEMS OI
JOIN PRODUCTS P ON OI.product_id = P.product_id
GROUP BY P.category
ORDER BY Total_Revenue DESC;
```

> This joins `PRODUCTS` and `ORDER_ITEMS` to compute revenue per category.

---

##  Top 10 Customers by Lifetime Value

We list the 10 customers who have spent the most since their first purchase.

```sql
SELECT TOP 10 
       C.customer_id, 
       C.name, 
       C.email, 
       SUM(O.total_amount) AS Lifetime_Value
FROM CUSTOMERS C
JOIN ORDERS O ON C.customer_id = O.customer_id
GROUP BY C.customer_id, C.name, C.email
ORDER BY Lifetime_Value DESC;
```

> Lifetime Value (CLV) is the sum of all orders per customer. This query helps identify high-value customers.

---

##  Percentage of Repeat Customers

We calculate what percentage of customers have placed more than one order.

```sql
SELECT CAST(
    100.0 * COUNT(*) / 
    (SELECT COUNT(*) FROM CUSTOMERS) AS DECIMAL(5,2)
) AS Percentage_Multiple_Orders
FROM (
    SELECT customer_id 
    FROM ORDERS 
    GROUP BY customer_id 
    HAVING COUNT(*) > 1
) AS MultiOrderCustomers;
```

> This identifies how many customers placed multiple orders, compared to total customers.

---

##  Top 5 Best-Selling Products per Category

This finds the top 5 selling products (by quantity) in each product category.

```sql
WITH RankedProducts AS (
    SELECT 
        P.category, 
        P.name, 
        SUM(OI.quantity) AS total_quantity, 
        RANK() OVER (PARTITION BY P.category ORDER BY SUM(OI.quantity) DESC) AS rank
    FROM ORDER_ITEMS OI
    JOIN PRODUCTS P ON OI.product_id = P.product_id
    GROUP BY P.category, P.name
)
SELECT category, name, total_quantity
FROM RankedProducts
WHERE rank <= 5;
```

> Uses a Common Table Expression (CTE) and `RANK()` to select the top 5 products in each category.

---

##  High Stock but Low Sales

We identify products with a large amount of inventory but very few sales.

```sql
SELECT 
    a.name, 
    SUM(b.quantity) AS sold, 
    a.stock_quantity, 
    a.stock_quantity - SUM(b.quantity) AS remaining,
    (SUM(b.quantity) * 1.0) / (a.stock_quantity * 1.0) AS sold_ratio
FROM products a
JOIN order_items b ON a.product_id = b.product_id
GROUP BY a.name, a.stock_quantity
ORDER BY sold_ratio DESC;
```

> Highlights stock-rich items that aren't selling well—useful for inventory management.

---

##  Orders with Incorrect Totals

We verify if the order's recorded total matches the sum of individual item prices.

```sql
SELECT 
    O.order_id, 
    O.total_amount, 
    SUM(OI.quantity * OI.price) AS calculated_total
FROM ORDERS O
JOIN ORDER_ITEMS OI ON O.order_id = OI.order_id
GROUP BY O.order_id, O.total_amount
HAVING ROUND(SUM(OI.quantity * OI.price), 2) != ROUND(O.total_amount, 2);
```

> Detects discrepancies between recorded and calculated order totals.

---

##  Duplicate Emails

We check for duplicate email addresses in the customer database.

```sql
SELECT email, 
       COUNT(*) AS duplicate_count
FROM CUSTOMERS
GROUP BY email
HAVING COUNT(*) > 1;
```

> Helps identify potential data entry errors or duplicated accounts.

---

##  Bonus: Customer Lifetime Value View (Stored Procedure)

This stored procedure shows how much each customer has spent.

```sql
CREATE PROCEDURE GetCustomerLifetimeValue AS
BEGIN
    SELECT 
        C.customer_id, 
        C.name, 
        C.email, 
        SUM(O.total_amount) AS Lifetime_Value
    FROM CUSTOMERS C
    JOIN ORDERS O ON C.customer_id = O.customer_id
    GROUP BY C.customer_id, C.name, C.email;
END;
```

> This procedure simplifies querying customer CLV repeatedly.


