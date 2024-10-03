USE Northwind
GO
--14
SELECT DISTINCT p.ProductName
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE YEAR(o.OrderDate) >= YEAR(GETDATE()) - 27;

--15
SELECT TOP 5 c.PostalCode, COUNT(*) AS ProductCount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.PostalCode
ORDER BY ProductCount DESC;

--16
SELECT TOP 5 c.PostalCode, COUNT(*) AS ProductCount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) >= YEAR(GETDATE()) - 27
GROUP BY c.PostalCode
ORDER BY ProductCount DESC;

--17
SELECT c.City, COUNT(*) AS CustomerCount
FROM Customers c
GROUP BY c.City;

--18
SELECT c.City, COUNT(*) AS CustomerCount
FROM Customers c
GROUP BY c.City
HAVING COUNT(*) > 2;

--19
SELECT c.ContactName, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01';

--20
SELECT c.ContactName, MAX(o.OrderDate) AS RecentOrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName;

--21
SELECT c.ContactName, COUNT(od.ProductID) AS ProductCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.ContactName;

--22
SELECT c.CustomerID, COUNT(od.ProductID) AS ProductCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING COUNT(od.ProductID) > 100;

--23


--24
SELECT o.OrderDate, p.ProductName
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

--25
SELECT e1.EmployeeID, e2.EmployeeID, e1.Title
FROM Employees e1
JOIN Employees e2 ON e1.Title = e2.Title AND e1.EmployeeID < e2.EmployeeID;

--26


--27
SELECT City, CompanyName AS Name, ContactName, 'Customer' AS Type
FROM Customers
UNION
SELECT City, CompanyName AS Name, ContactName, 'Supplier' AS Type
FROM Suppliers;