--1. # product
Use AdventureWorks2019
Go

SELECT COUNT(*)
FROM Production.Product

--2. # products s.t. don't have NULL in ProductSubcategoryID
SELECT COUNT(ProductSubcategoryID)
FROM Production.Product

--3. # Products reside in each SubCategory with the titles ProductSubcategoryID, CountedProducts
SELECT ProductSubcategoryID, COUNT(ProductSubcategoryID) AS CountedProducts
FROM Production.Product
GROUP BY ProductSubcategoryID

--4. # products that do not have a product subcategory.
SELECT COUNT(*) - COUNT(ProductSubcategoryID)
FROM Production.Product

--5. list the sum of products quantity in the Production.ProductInventory table.
SELECT SUM(Quantity)
FROM Production.ProductInventory

--6. list the sum of products, LocationID set to 40 and limit the result to include just summarized quantities < 100.
SELECT ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) < 100



--7.
SELECT Shelf, ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY Shelf, ProductID
HAVING SUM(Quantity) < 100

--8.
SELECT AVG(Quantity)
FROM Production.ProductInventory
WHERE LocationID = 10

--9. 
SELECT Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
GROUP BY Shelf

--10.
SELECT Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY Shelf

--11.
SELECT Color, Class, COUNT(ProductID) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class

--12.
SELECT c.Name AS Country, s.Name AS Province
FROM Person.CountryRegion c JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode

--13.
SELECT c.Name AS Country, s.Name AS Province
FROM Person.CountryRegion c JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name IN ('Germany','Canada') 


--14. 
Use Northwind
Go

SELECT DISTINCT p.ProductName
FROM Products p JOIN [Order Details] d ON p.ProductID = d.ProductID JOIN Orders o ON d.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -26, GETDATE());

--15.
SELECT TOP 5 o.ShipPostalCode, SUM(d.Quantity) AS TheCount
FROM [Order Details] d JOIN Orders o ON d.OrderID = o.OrderID
GROUP BY o.ShipPostalCode
ORDER BY SUM(d.Quantity) DESC

--16. 
SELECT TOP 5 o.ShipPostalCode, SUM(d.Quantity) AS TheCount
FROM [Order Details] d JOIN Orders o ON d.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -26, GETDATE())
GROUP BY o.ShipPostalCode
ORDER BY SUM(d.Quantity) DESC


--17.  
SELECT c.City, COUNT(c.CustomerID) as TheCount
FROM Customers c
GROUP BY c.City

--18. 
SELECT c.City, COUNT(c.CustomerID) as TheCount
FROM Customers c
GROUP BY c.City
HAVING COUNT(c.CustomerID) > 2


--19. 
SELECT c.ContactName, o.OrderDate
FROM Orders o JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01'

--20. 
SELECT dt.ContactName
FROM (SELECT c.ContactName, o.OrderDate, RANK() OVER (ORDER BY o.OrderDate DESC) RNK
FROM Orders o JOIN Customers c ON c.CustomerID = o.CustomerID) dt 
WHERE dt.RNK = 1

--21.
SELECT c.ContactName, SUM(d.Quantity) AS TheCount
FROM Orders o JOIN Customers c ON c.CustomerID = o.CustomerID JOIN [Order Details] d on d.OrderID = o.OrderID
GROUP BY c.ContactName

--22.


--23.


--24. 


--25.


--26.


--27. 
