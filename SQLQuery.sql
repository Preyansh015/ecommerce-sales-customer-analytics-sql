--Generate a Monthly Revenue Report to analyze sales performance and identify revenue trends over time.
SELECT
    YEAR(OrderDate) AS SalesYear,
    MONTH(OrderDate) AS SalesMonth,
    SUM(TotalAmount) AS MonthlyRevenue
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY SalesYear, SalesMonth;

--Identify the Top 10 Revenue-Generating Customers based on their total purchase value.
SELECT TOP 10
    c.CustomerID,
    c.CustomerName,
    SUM(o.TotalAmount) AS Total_Revenue
FROM Customers c
JOIN Orders o
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY
    Total_Revenue DESC;

--Determine the Top 10 Best-Selling Products based on the total quantity sold.
SELECT TOP 10
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS Total_Quantity_Sold
FROM Products p
JOIN OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY
    p.ProductID,
    p.ProductName
ORDER BY
    Total_Quantity_Sold DESC;

--Calculate the Average Order Value (AOV) to evaluate customer spending behavior.
SELECT
    AVG(TotalAmount) AS Average_Order_Value
FROM Orders;

--Identify Customers Who Have Never Placed an Order to support targeted marketing campaigns.
SELECT
    c.CustomerID,
    c.CustomerName
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

--Analyze Repeat Customers by identifying customers who have placed multiple orders.

SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
HAVING COUNT(o.OrderID) > 1;

--Calculate Customer Lifetime Value (CLV) to measure each customer's total contribution to revenue.
SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(o.TotalAmount) AS Customer_Lifetime_Value
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY
    Customer_Lifetime_Value DESC;

--Generate a City-Wise Revenue Report to identify high-performing geographical markets.
SELECT
    c.City,
    SUM(o.TotalAmount) AS Revenue
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.City
ORDER BY
    Revenue DESC;

--Identify Products That Have Never Been Purchased to optimize inventory and product offerings.
SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    p.Brand
FROM Products p
LEFT JOIN OrderDetails od
    ON p.ProductID = od.ProductID
WHERE od.ProductID IS NULL;

--Analyze Category-Wise Revenue to determine the highest-performing product categories.
SELECT
    p.Category,
    SUM(od.Quantity * od.UnitPrice) AS Total_Revenue
FROM Products p
JOIN OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY
    p.Category
ORDER BY
    Total_Revenue DESC; 

--Identify the Highest Revenue-Generating Product based on total sales value.
SELECT TOP 1
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity * od.UnitPrice) AS Total_Revenue
FROM Products p
JOIN OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY
    p.ProductID,
    p.ProductName
ORDER BY
    Total_Revenue DESC;

-- Generate a Low Stock Report to identify products that require inventory replenishment.

SELECT
    ProductID,
    ProductName,
    Category,
    Brand,
    Stock
FROM Products
WHERE Stock < 20
ORDER BY Stock ASC;

--Prepare an Order Status Summary showing the distribution of orders across different order statuses.
SELECT
    OrderStatus,
    COUNT(OrderID) AS Total_Orders
FROM Orders
GROUP BY
    OrderStatus
ORDER BY
    Total_Orders DESC;

--Analyze Customer Payment Preferences by identifying the most frequently used payment methods.
SELECT TOP 1
    PaymentMethod,
    COUNT(*) AS Total_Transactions
FROM Orders
GROUP BY
    PaymentMethod
ORDER BY
    Total_Transactions DESC;

-- Generate a Daily Sales Performance Report to monitor day-to-day business activity.

SELECT
    OrderDate,
    COUNT(OrderID) AS Total_Orders,
    SUM(TotalAmount) AS Daily_Revenue
FROM Orders
GROUP BY
    OrderDate
ORDER BY
    OrderDate;


