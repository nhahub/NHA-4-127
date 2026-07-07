USE AdventureWorks2019;
CREATE OR ALTER VIEW dbo.vw_FactSalesAnalysis AS
SELECT

-----------------------------
-- Order Information
-----------------------------
SOH.SalesOrderID,
SOD.SalesOrderDetailID,

SOH.OrderDate,
SOH.DueDate,
SOH.ShipDate,

YEAR(SOH.OrderDate)              AS OrderYear,
MONTH(SOH.OrderDate)             AS OrderMonth,
DATENAME(MONTH, SOH.OrderDate)   AS MonthName,
DATEPART(QUARTER, SOH.OrderDate) AS OrderQuarter,
DAY(SOH.OrderDate)               AS OrderDay,
DATENAME(WEEKDAY, SOH.OrderDate) AS DayName,

SOH.Status,
SOH.OnlineOrderFlag,

-----------------------------
-- Customer
-----------------------------
C.CustomerID,

CASE
    WHEN P.BusinessEntityID IS NULL
        THEN 'Store Customer'
    ELSE CONCAT(P.FirstName,' ',P.LastName)
END AS CustomerName,

-----------------------------
-- Product
-----------------------------
PR.ProductID,
PR.Name AS ProductName,
PR.ProductNumber,

PR.Color,
PR.Class,
PR.ProductLine,

PR.StandardCost,
PR.ListPrice,

-----------------------------
-- Category
-----------------------------
PSC.Name AS Subcategory,
PC.Name AS Category,

-----------------------------
-- Sales
-----------------------------
SOD.OrderQty,
SOD.UnitPrice,
SOD.UnitPriceDiscount,
SOD.LineTotal AS SalesAmount,

(PR.StandardCost * SOD.OrderQty) AS CostAmount,

(SOD.LineTotal - (PR.StandardCost * SOD.OrderQty)) AS Profit,

CASE
    WHEN SOD.LineTotal = 0 THEN NULL
    ELSE
        (
            (SOD.LineTotal - (PR.StandardCost * SOD.OrderQty))
            / SOD.LineTotal
        ) * 100
END AS ProfitMargin,

-----------------------------
-- Territory
-----------------------------
ST.TerritoryID,
ST.Name AS Territory,
ST.CountryRegionCode,
ST.[Group] AS TerritoryGroup,

-----------------------------
-- SalesPerson
-----------------------------
SOH.SalesPersonID

FROM Sales.SalesOrderDetail AS SOD

INNER JOIN Sales.SalesOrderHeader AS SOH
    ON SOD.SalesOrderID = SOH.SalesOrderID

INNER JOIN Production.Product AS PR
    ON SOD.ProductID = PR.ProductID

LEFT JOIN Production.ProductSubcategory AS PSC
    ON PR.ProductSubcategoryID = PSC.ProductSubcategoryID

LEFT JOIN Production.ProductCategory AS PC
    ON PSC.ProductCategoryID = PC.ProductCategoryID

INNER JOIN Sales.Customer AS C
    ON SOH.CustomerID = C.CustomerID

LEFT JOIN Person.Person AS P
    ON C.PersonID = P.BusinessEntityID

LEFT JOIN Sales.SalesTerritory AS ST
    ON SOH.TerritoryID = ST.TerritoryID;