/* These Queries were done working Retail Data to answer the 4 question provided.
 The customers table had the key Customer_ID and Customer_Name
 The Sales table had the key Customer_ID, and columns Tran_date, Item_ID, Reporting_Classification, and Total_USD
 The Items table had the key Item_ID, and columns Product_Line, Ithem_Type, and Item_Name */


--SQL Questions:

--Write a query to obtain Customer Name and total Revenues
	SELECT c.Customer_Name, 
SUM(s.Total_USD)AS total_revenue
FROM `sales` AS s 
JOIN `customers` AS c 
ON s.Customer_ID = c.Customer_ID
WHERE s.Reporting_Classification = "Revenue"
GROUP BY c.Customer_Name
ORDER BY total_revenue DESC
 
--Write a query to obtain Item Type and total Costs of Sales
SELECT i.Item_Type, 
SUM(s.Total_USD) as total_cost
FROM `sales` AS s 
JOIN `items` AS i
ON s.Item_ID = i.Item_ID
WHERE s.Reporting_Classification = "Cost of sales"
GROUP BY i.Item_Type
 
--Write a query to obtain Customer Name, and Gross Profit
SELECT c.Customer_Name, 
SUM(s.Total_USD)AS gross_profit
FROM `sales` AS s 
JOIN `customers` AS c 
ON s.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
ORDER BY gross_profit DESC
 
--Write a query to obtain all Customers and their total Revenues, regardless of whether they purchased anything
SELECT c.Customer_ID,
c.Customer_Name, 
COALESCE
(SUM(s.Total_USD)
, 0)
AS total_revenue,
FROM `customers` AS c 
FULL OUTER JOIN `sales` AS s 
ON c.Customer_ID = s.Customer_ID
WHERE s.Reporting_Classification = "Revenue" OR
s.Reporting_Classification IS NULL
GROUP BY c.Customer_ID, c.Customer_Name 
ORDER BY total_revenue DESC
 
