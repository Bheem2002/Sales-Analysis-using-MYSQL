
-- Q1: Find all orders shipped via 'Economy' mode with a total amount greater than ₹25,000.
SELECT * 
FROM Sales
WHERE Ship_Mode = 'Economy' AND Total_Amount > 25000;

-- Q2: Retrieve all sales data for 'Technology' category in 'Ireland' made after 2020-01-01.
SELECT * 
FROM Sales
WHERE Category = 'Technology' AND Country = 'Ireland' AND Order_Date > '2020-01-01';

-- Q3: List the top 10 most profitable sales transactions in descending order.
SELECT * 
FROM Sales
ORDER BY Unit_Profit * Sold_Quantity DESC
LIMIT 10;

-- Q4: Find all customers whose name starts with 'J' and ends with 'n'.
SELECT DISTINCT Customer_Name 
FROM Sales
WHERE Customer_Name LIKE 'J%n';

-- Q5: Retrieve all product names that contain 'Acco' anywhere in the name.
SELECT DISTINCT Product_Name 
FROM Sales
WHERE Product_Name LIKE '%Acco%';

-- Q6: Get the top 5 cities with the highest total sales amount.
SELECT City, SUM(Total_Amount) AS Total_Sales
FROM Sales
WHERE City IS NOT NULL
GROUP BY City
ORDER BY Total_Sales DESC
LIMIT 5;

-- Q7: Find the total revenue, average unit cost, and total number of orders.
SELECT 
    SUM(Total_Amount) AS Total_Revenue,
    AVG(Unit_Cost) AS Average_Unit_Cost,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM Sales;

-- Q8: Get total sales per product category.
SELECT Category, SUM(Total_Amount) AS Total_Sales
FROM Sales
GROUP BY Category;

-- Q9: Get customers who have placed orders worth more than ₹50,000.
SELECT Customer_Name, SUM(Total_Amount) AS Customer_Total
FROM Sales
GROUP BY Customer_Name
HAVING Customer_Total > 50000;

-- Q10: Find the top 5 customers by sales revenue using DENSE_RANK()
SELECT * FROM (
    SELECT 
        Customer_Name,
        SUM(Total_Amount) AS Total_Sales,
        DENSE_RANK() OVER (ORDER BY SUM(Total_Amount) DESC) AS Sales_Rank
    FROM Sales
    GROUP BY Customer_Name
) ranked_customers
WHERE Sales_Rank <= 5;
