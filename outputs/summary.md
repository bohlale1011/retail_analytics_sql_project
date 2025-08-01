 #PDF To Markdown Converter
Debug View
Result View
Sales Analysis Report Summary

Monthly Revenue Trend:
We check how much money we made each month in the past year. We do this by adding
up the total order money for each month.

SELECT FORMAT(order_date, 'yyyy-MM') AS [Month], 

SUM(total_amount) AS Monthly_Revenue

FROM ORDERS

WHERE order_date >= DATEADD(YEAR, -1, GETDATE())

GROUP BY FORMAT(order_date, 'yyyy-MM')

ORDER BY [Month];

Month Monthly_Revenue

2024 - 08 1670.

2024 - 09 1325.

2024 - 10 2174.

2024 - 11 1981.

2024 - 12 2393.

2025 - 01 1499.

2025 - 02 1582.

2025 - 03 2419.

2025 - 04 2469.

2025 - 05 1882.

2025 - 06 1742.

2025 - 07 1551.

We use the FORMAT function to group orders by month over the last year, then sum the
total revenue per month.

Product Categories Revenue:
We find out which types of products made the most money by multiplying how many were
sold by their prices.

SELECT P.category, SUM(OI.quantity * OI.price) AS Total_Revenue

FROM ORDER_ITEMS OI

JOIN PRODUCTS P ON OI.product_id = P.product_id

GROUP BY P.category

ORDER BY Total_Revenue DESC;

category Total_Revenue

Food - Snacks 429911.

Kitchen 388265.

Home 346933.

Photography 335269.

Food - Bakery 332217.

Fitness 313149.

Pets 278270.

Food - Condiments263557.

Food - Salads 198703.

Food - Canned Goods193804.

Beauty 172185.

Food - Grains 168698.

This query joins products and order_items to group revenue per category using quantity *
price. Customer Insights

We list the 10 customers who spent the most money since they started buying.

SELECT TOP 10 C.customer_id, C.name, C.email, SUM(O.total_amount) AS
Lifetime_Value FROM CUSTOMERS C

JOIN ORDERS O ON C.customer_id = O.customer_id

GROUP BY C.customer_id, C.name, C.email

ORDER BY Lifetime_Value DESC;

customer_id name email Lifetime_Value 101 Prentiss
pizatson2s@walmart.com 554.96 276 Aron ascolland7n@sogou.com 552.
227 Margie mmcinnerny6a@ebay.com 436.45 82 Wenda
wtreadgear29@linkedin.com 385.93 241 Gradeigh gtejero6o@ucla.edu
349.95 275 Fredericka fwreight7m@networkadvertising.org 321.43 277 Isa
igerriessen7o@geocities.jp 319.98 63 Nappie
nyendall1q@chicagotribune.com 317.15 221 Leonidas lwyse64@exblog.jp
305.77 230 Agace agauch6d@bbc.co.uk 287.

Lifetime Value (CLV) is calculated by summing all orders per customer. We sort and take
the top 10.

Percentage of Repeat Customers:
We find how many customers ordered more than once, and show this as a percentage of
all customers.

SELECT CAST(100.0 * COUNT() / (SELECT COUNT() FROM CUSTOMERS) AS
DECIMAL(5,2)) AS Percentage_Multiple_Orders

FROM ( SELECT customer_id FROM ORDERS GROUP BY customer_id HAVING
COUNT(*) > 1 ) AS MultiOrderCustomers;

Percentage_Multiple_Orders 83.

We calculate the percentage of customers who made more than one order by comparing
grouped orders with total customers. Product Performance

Top 5 Best-Selling Products per Category:
We look at each product category and list the 5 products that sold the most.

WITH RankedProducts AS (

SELECT P.category, P.name, SUM(OI.quantity) AS total_quantity, RANK()
OVER (PARTITION BY P.category ORDER BY SUM(OI.quantity) DESC) AS rank

FROM ORDER_ITEMS OI

JOIN PRODUCTS P ON OI.product_id = P.product_id

GROUP BY P.category, P.name ) SELECT category, name, total_quantity
FROM RankedProducts WHERE rank <= 5;

category name total_quantity

Accessories Sunglasses 96

Beauty Travel Hair Straightener 161

Clothing - Dresses Pleated Midi Dress 27

Clothing - Footwear Canvas High-Top Sneakers 13

Electronics Adjustable Stand for Tablets and Smartphones 122

Fitness Fitness Balance Ball 135

Fitness Yoga Mat 124

Food - Bakery Garlic Naan Bread 187

Food - Bakery Pumpkin Spice Cookies 142

Food - Bakery French Bread 85

Food - Bakery Cinnamon Raisin Bagels 23

Food - Baking Granulated Sugar 120

Food - Beverages Pumpkin Spice Creamer 76

Food - Canned Goods Tomato Paste 113

Food - Canned Goods Apple Sauce 36

Food - Canned Goods Spaghetti Sauce 25

Accessories 160320.
Outdoor 158306.
Toys 152040.
Food - Frozen Vegetables 143524.
Food - Freezer 111178.
Food - Pantry 96330.
Food - Baking 90362.
Safety 85644.
Food - Beverages 85044.
Food - Frozen Foods 80182.
Music 62568.
Electronics 62120.
Garden 27608.
Food - Dairy 26622.
Clothing - Footwear 23517.
Food - Frozen 17748.
Food - Meat Substitutes 13110.
Food - Frozen Desserts 8280.
Food - Sauces 5434.
Clothing - Dresses 351.
Food - Condiments Thai Red Curry Paste
Food - Condiments Fire Roasted Salsa
Food - Condiments Chipotle Sauce
Food - Condiments Pesto Genovese
Food - Condiments Spicy Avocado Salsa
Food - Dairy Ricotta Cheese
Food - Freezer Buffalo Cauliflower Bites
Food - Frozen Thai Basil Fried Rice
Food - Frozen Desserts Mint Chocolate Chip Ice Cream
Food - Frozen Foods Butternut Squash Ravioli
Food - Frozen Foods Cauliflower Rice Stir-Fry
Food - Frozen Vegetables Cheesy Cauliflower Bake
Food - Grains Wild Rice & Quinoa Mix
Food - Grains Herbed Couscous
Food - Grains Pineapple Coconut Rice Mix
Food - Meat Substitutes Veggie Burger Patties
Food - Pantry Nutritional Yeast
Food - Salads Mediterranean Couscous Salad
Food - Sauces Roasted Red Pepper Sauce
Food - Snacks Hummus Trio Pack
Food - Snacks Kettle Corn Popcorn
Food - Snacks Caramel Apple Chips
Garden Self-Watering Planter
Home Bamboo Bathtub Caddy
Home Memory Foam Mattress Topper
Home Memory Foam Pillow
Home Reversible Comforter Set
Kitchen Pasta Maker
Kitchen Electric Hot Pot
Kitchen Snap-On Tupperware Set 64

Kitchen Electric Meat Grinder 47

Kitchen Heat-Resistant Silicone Mat 34

Music Acoustic Guitar 79

Outdoor Outdoor Mosquito Repellent Lantern 100

Outdoor Tabletop Fire Pit 9

Pets Pet Carrier 191

Pets Pet Training Clicker 69

Photography Smartphone Tripod 167

Photography Smartphone Tripod with Remote 126

Safety Personal Safety Alarm 98

Safety Noise Cancelling Ear Muffs 71

Toys Kids' Trampoline 84

Using a CTE and RANK() to find the top 5 products by total quantity sold in each category.

High Stock but Low Sales:
These are products we have a lot of in our store or warehouse but not many people are
buying them.

SELECT 
    a.name, 
    SUM(b.quantity) AS sold, 
    a.stock_quantity, 
    a.stock_quantity - SUM(b.quantity) AS remaining,
    (SUM(b.quantity) * 1.0) / (a.stock_quantity * 1.0) AS sold_ratio
FROM 
    products a
JOIN 
    order_items b ON a.product_id = b.product_id
GROUP BY 
    a.name, a.stock_quantity
ORDER BY 
    sold_ratio DESC;


product_id	name	category	stock_quantity	total_sold
75	Mini Fondue Set	Kitchen	1989	0
90	Pet Safety Harness	Pets	1865	0
71	LED Canopy Lights	Outdoor	1853	0
60	Thai Peanut Dressing	Food - Condiments	1809	0
80	Ankle Boots	Clothing - Footwear	1784	0
3	Smartphone Car Mount with Wireless Charging	Automotive	1781	0
37	Children's Science Experiment Lab Kit	Toys	1641	0
88	LED Flashlight	Outdoor	1558	0
13	Craft Beer Mustard	Food - Condiments	1478	0
84	Harvest Grain Salad	Food - Salads	1456	0
5	Vegetable Pizza Rolls	Food - Frozen Foods	1422	0
33	Toy Building Set	Toys	1411	0
57	Beef Chili	Food - Canned Goods	1337	0
89	Chocolate Mint Protein Shake	Food - Beverages	1238	0
25	Pineapple Rings	Food - Canned Goods	1192	0
15	Frozen Berry Medley	Food - Frozen Foods	1089	0
8	Digital Thermostat	Home	1062	0
28	Tabletop Fire Pit	Outdoor	991	9
31	Almond Butter Granola Bars	Food - Snacks	967	0
30	Cabbage Slaw Mix	Food - Vegetables	927	0
58	Chili Garlic Sauce	Food - Condiments	886	0
27	Suede Ankle Booties	Clothing - Footwear	865	0
63	Plaid Flannel Shirt	Clothing - Tops	836	0
9	Classic White T-Shirt	Clothing - Tops	824	0
83	Peach & Mango Salsa	Food - Snacks	820	0
24	Chicken Parmesan Dinner Kit	Food - Frozen Meals	801	0
79	Vegetable Quinoa Bowl	Food - Frozen Meals	773	0
22	Wireless Charging Pad	Accessories	717	0
26	Oven-Baked Parmesan Zucchini	Food - Frozen Vegetables	686	0
76	Smartwatch	Wearable Tech	670	0
96	Cucumber Relish	Food - Condiments	665	0
41	Cauliflower Rice Stir-Fry	Food - Frozen Foods	554	9
4	Pet Travel Bowl	Pets	477	0
48	Margherita Pizza	Food - Frozen Foods	454	0
23	Rain Jacket	Clothing	394	0
47	Zucchini	Food - Produce	333	0
14	Stainless Steel Mixing Bowls	Kitchen	275	0
19	Protein Pancake Mix	Food - Breakfast	224	0
56	Stainless Steel Travel Mug	Kitchen	200	0
11	Stuffed Grape Leaves	Food - Prepared Foods	144	0
95	Smartphone UV Sanitizer	Health	134	0

We list products with stock > 100 and sales < 10 using LEFT JOIN and GROUP BY.
Operational & Data Quality

Orders with Incorrect Totals:
We check if the total cost in the order is different from the sum of the prices of items
bought. This could mean there’s a mistake.

SELECT O.order_id, O.total_amount, SUM(OI.quantity * OI.price) AS
calculated_total FROM ORDERS O

JOIN ORDER_ITEMS OI ON O.order_id = OI.order_id GROUP BY O.order_id,
O.total_amount HAVING ROUND(SUM(OI.quantity * OI.price), 2) !=
ROUND(O.total_amount, 2);

Check if the order's total_amount matches the calculated sum from order_items.

Duplicate Emails:
We see if any customers are using the same email more than once. That might be an error.

SELECT
email,

COUNT(*) AS duplicate_count

FROM

CUSTOMERS

GROUP BY

email

HAVING

COUNT(*) > 1;

Detect repeated email addresses in the customers table.

Bonus View Customer_Lifetime_Value View:

We created a program (called a stored procedure) that shows how much money each
customer has spent. We can use this program anytime without writing the full query again.

CREATE PROCEDURE GetCustomerLifetimeValue AS

BEGIN

SELECT C.customer_id, C.name, C.email, SUM(O.total_amount) AS
Lifetime_Value

FROM CUSTOMERS C

JOIN ORDERS O ON C.customer_id = O.customer_id GROUP BY C.customer_id,
C.name, C.email;

END;

A view that calculates total value each customer has spent. Can be queried repeatedly for
reporting CLV.

This is a offline tool, your data stays locally and is not send to any server!
Feedback & Bug Reports
