USE AdventureWorks2019;

-- 1. Preview Data
SELECT TOP (20) *
FROM dbo.vw_FactSalesAnalysis;



-- 2. Validate Total Rows ---> Row count should match Sales.SalesOrderDetail
SELECT
    COUNT(*) AS ViewRows
FROM dbo.vw_FactSalesAnalysis;

SELECT
    COUNT(*) AS SalesOrderDetailRows
FROM Sales.SalesOrderDetail;



-- 3. Check Missing Product Names ---> No NULL values
SELECT *
FROM dbo.vw_FactSalesAnalysis
WHERE ProductName IS NULL;



-- 4. Check Missing Sales Amount ---> No NULL values
SELECT *
FROM dbo.vw_FactSalesAnalysis
WHERE SalesAmount IS NULL;



-- 5. Validate Product Categories ---> Accessories / Bikes / Clothing / Components
SELECT DISTINCT
    Category
FROM dbo.vw_FactSalesAnalysis
ORDER BY Category;



-- 6. Validate Date Range ---> Data covers the AdventureWorks sales period
SELECT
    MIN(OrderDate) AS FirstOrderDate,
    MAX(OrderDate) AS LastOrderDate
FROM dbo.vw_FactSalesAnalysis;



-- 7. Check Duplicate Sales Order Detail IDs ---> No duplicate rows
SELECT
    SalesOrderDetailID,
    COUNT(*) AS DuplicateCount
FROM dbo.vw_FactSalesAnalysis
GROUP BY SalesOrderDetailID
HAVING COUNT(*) > 1;



-- 8. Check Negative Sales Amount ---> No negative sales values
SELECT *
FROM dbo.vw_FactSalesAnalysis
WHERE SalesAmount < 0;



-- 9. Check Negative Quantity ---> No negative quantities
SELECT *
FROM dbo.vw_FactSalesAnalysis
WHERE OrderQty <= 0;