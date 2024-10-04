USE Northwind
GO

--1
SELECT DISTINCT e.City 
FROM Employees e
JOIN Customers c ON e.City = c.City;

--2.a
SELECT DISTINCT c.City 
FROM Customers c
WHERE c.City NOT IN (
    SELECT e.City 
    FROM Employees e
);

--2.b
SELECT DISTINCT c.City 
FROM Customers c
LEFT JOIN Employees e ON c.City = e.City
WHERE e.City IS NULL;

--3
SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantity
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;

--4
SELECT c.City, SUM(od.Quantity) AS TotalQuantity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City;

--5
SELECT c.City, COUNT(DISTINCT c.CustomerID) AS CustomerCount
FROM Customers c
GROUP BY c.City
HAVING COUNT(DISTINCT c.CustomerID) >= 2;

--6
SELECT c.City, COUNT(DISTINCT od.ProductID) AS ProductCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) >= 2;

--7
SELECT c.CustomerID, c.City AS CustomerCity, o.ShipCity 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City <> o.ShipCity;

--8
WITH ProductPopularity AS (
    SELECT p.ProductName, AVG(od.UnitPrice) AS AvgPrice, SUM(od.Quantity) AS TotalQuantity, c.City
    FROM Products p
    JOIN [Order Details] od ON p.ProductID = od.ProductID
    JOIN Orders o ON o.OrderID = od.OrderID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    GROUP BY p.ProductName, c.City
)
SELECT TOP 5 ProductName, AvgPrice, City, TotalQuantity
FROM ProductPopularity
ORDER BY TotalQuantity DESC;

--9.a
SELECT DISTINCT e.City
FROM Employees e
WHERE e.City NOT IN (
    SELECT c.City 
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
);

--9.b
SELECT DISTINCT e.City
FROM Employees e
LEFT JOIN Customers c ON e.City = c.City
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

--10
WITH EmployeeOrders AS (
    SELECT e.City AS EmployeeCity, COUNT(o.OrderID) AS OrderCount
    FROM Employees e
    JOIN Orders o ON e.EmployeeID = o.EmployeeID
    GROUP BY e.City
),
CustomerOrders AS (
    SELECT c.City AS CustomerCity, SUM(od.Quantity) AS TotalQuantity
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY c.City
)
SELECT eo.EmployeeCity
FROM EmployeeOrders eo
JOIN CustomerOrders co ON eo.EmployeeCity = co.CustomerCity
ORDER BY eo.OrderCount DESC, co.TotalQuantity DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

