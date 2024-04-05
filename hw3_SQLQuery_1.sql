--1. 
SELECT DISTINCT c.City
FROM Customers c JOIN Employees e ON c.City = e.City

--2.a sub-query
SELECT DISTINCT City
FROM Customers
WHERE City NOT IN (SELECT DISTINCT City
FROM Employees)

--2.b not use sub-query
SELECT DISTINCT c.City
FROM Customers c LEFT JOIN Employees e ON c.City = e.City
WHERE e.City IS NULL

--3.
SELECT p.ProductID, SUM(od.Quantity) AS TheCount
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductID

--4. 
SELECT c.City, SUM(od.Quantity) AS TheCount
FROM Customers c JOIN Orders o ON c.City=o.ShipCity JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City

--5.a UNION
SELECT c1.City
FROM Customers c1 JOIN  Customers c2 ON c1.City = c2.City
WHERE c1.ContactName != c2.ContactName

UNION

SELECT c1.City
FROM Customers c1 JOIN  Customers c2 ON c1.City = c2.City
WHERE c1.ContactName != c2.ContactName


--5.b NO UNION and use sub-query
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) >= 2

--6. 
SELECT c.City
FROM Customers c JOIN Orders o ON c.City=o.ShipCity JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) > 1

--7. 
SELECT DISTINCT c.CustomerID
FROM Customers c JOIN Orders o ON c.CustomerID=o.CustomerID
WHERE c.City != o.ShipCity

--8. 

SELECT TOP 5 p.ProductID, AVG(od.UnitPrice) AS AvgPrice
FROM Products p JOIN [Order Details] od ON od.ProductID=p.ProductID JOIN Orders o ON o.OrderID = od.OrderID
GROUP BY p.ProductID
ORDER BY SUM(od.Quantity) DESC

--9.a sub-query
SELECT City
FROM Employees
WHERE City NOT IN (SELECT ShipCity
FROM Orders)

--9.b not using sub-query
SELECT DISTINCT e.City
FROM Employees e LEFT JOIN Orders o ON e.City = o.ShipCity
WHERE o.ShipCity IS NULL

--10.
WITH TopEmployeeCity AS (
    SELECT TOP 1 e.City
    FROM Orders o JOIN Employees e ON o.EmployeeID = e.EmployeeID
    GROUP BY e.City
    ORDER BY COUNT(o.OrderID) DESC
),
MostProductOrderedCity AS (
    SELECT TOP 1 o.ShipCity
    FROM [Order Details] od JOIN Orders o ON od.OrderID = o.OrderID
    GROUP BY o.ShipCity
    ORDER BY SUM(od.Quantity) DESC
)
SELECT mp.ShipCity AS OneCity
FROM MostProductOrderedCity mp JOIN TopEmployeeCity te ON mp.ShipCity = te.City

--11. There's two methods to remove the duplicates. First, use DISTINCT. Second, use UNION.