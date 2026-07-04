USE AdventureWorks2019;
GO

/*=========================================================
1. Preview Data
=========================================================*/
SELECT TOP (20) *
FROM dbo.vw_FactSalesAnalysis;
GO


/*=========================================================
2. Validate Total Rows
Expected Result:
- Row count should match Sales.SalesOrderDetail
=========================================================*/
SELECT
    COUNT(*) AS ViewRows
FROM dbo.vw_FactSalesAnalysis;

SELECT
    COUNT(*) AS SalesOrderDetailRows
FROM Sales.SalesOrderDetail;
GO


/*=========================================================
3. Check Missing Product Names
Expected Result:
- No NULL values
=========================================================*/
SELECT *
FROM dbo.vw_FactSalesAnalysis
WHERE ProductName IS NULL;
GO


/*=========================================================
4. Check Missing Sales Amount
Expected Result:
- No NULL values
=========================================================*/
SELECT *
FROM dbo.vw_FactSalesAnalysis
WHERE SalesAmount IS NULL;
GO


/*=========================================================
5. Validate Product Categories
Expected Result:
Accessories
Bikes
Clothing
Components
=========================================================*/
SELECT DISTINCT
    Category
FROM dbo.vw_FactSalesAnalysis
ORDER BY Category;
GO


/*=========================================================
6. Validate Date Range
Expected Result:
Data covers the AdventureWorks sales period
=========================================================*/
SELECT
    MIN(OrderDate) AS FirstOrderDate,
    MAX(OrderDate) AS LastOrderDate
FROM dbo.vw_FactSalesAnalysis;
GO


/*=========================================================
7. Check Duplicate Sales Order Detail IDs
Expected Result:
No duplicate rows
=========================================================*/
SELECT
    SalesOrderDetailID,
    COUNT(*) AS DuplicateCount
FROM dbo.vw_FactSalesAnalysis
GROUP BY SalesOrderDetailID
HAVING COUNT(*) > 1;
GO


/*=========================================================
8. Check Negative Sales Amount
Expected Result:
No negative sales values
=========================================================*/
SELECT *
FROM dbo.vw_FactSalesAnalysis
WHERE SalesAmount < 0;
GO


/*=========================================================
9. Check Negative Quantity
Expected Result:
No negative quantities
=========================================================*/
SELECT *
FROM dbo.vw_FactSalesAnalysis
WHERE OrderQty <= 0;
GO