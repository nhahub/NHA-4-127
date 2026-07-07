USE AdventureWorks2019;
-- PRODUCT ANALYSIS

-- 1. Top 10 Products by Sales ---> Which products generate the highest sales revenue?
SELECT TOP (10)
    ProductName,
    SUM(SalesAmount) AS TotalSales
FROM dbo.vw_FactSalesAnalysis
GROUP BY ProductName
ORDER BY TotalSales DESC;


-- 2. Bottom 10 Products by Sales ---> Which products generate the lowest sales revenue?
SELECT TOP (10)
    ProductName,
    SUM(SalesAmount) AS TotalSales
FROM dbo.vw_FactSalesAnalysis
GROUP BY ProductName
ORDER BY TotalSales ASC;


-- 3. Profit by Product Category ---> Which product categories generate the highest profit?
SELECT
    Category,
    SUM(Profit) AS TotalProfit
FROM dbo.vw_FactSalesAnalysis
GROUP BY Category
ORDER BY TotalProfit DESC;


-- 4. Sales by Product Subcategory ---> Which product subcategories generate the highest sales?
SELECT
    Subcategory,
    SUM(SalesAmount) AS TotalSales
FROM dbo.vw_FactSalesAnalysis
GROUP BY Subcategory
ORDER BY TotalSales DESC;


-- 5. Top 10 Products by Profit ---> Which products generate the highest profit?
SELECT TOP (10)
    ProductName,
    SUM(Profit) AS TotalProfit
FROM dbo.vw_FactSalesAnalysis
GROUP BY ProductName
ORDER BY TotalProfit DESC;


-- 6. Top 10 Products by Profit Margin ---> Which products achieve the highest profit margin?
SELECT TOP (10)
    ProductName,
    SUM(SalesAmount) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    CAST
    (
        (SUM(Profit) * 100.0) /
        NULLIF(SUM(SalesAmount), 0)
        AS DECIMAL(18,2)
    ) AS ProfitMarginPercent
FROM dbo.vw_FactSalesAnalysis
GROUP BY ProductName
HAVING SUM(SalesAmount) > 0
ORDER BY ProfitMarginPercent DESC;


-- 7. High Quantity - Low Profit Products ---> Which products sell in high quantities but generate relatively low profit?
SELECT TOP (10)
    ProductName,
    SUM(OrderQty) AS TotalQuantity,
    SUM(SalesAmount) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM dbo.vw_FactSalesAnalysis
GROUP BY ProductName
HAVING SUM(OrderQty) > 100
ORDER BY
    TotalQuantity DESC,
    TotalProfit ASC;











-- CUSTOMER ANALYSIS

-- 1. Customer Segmentation ---> How can customers be segmented based on their total sales?
WITH CustomerSales AS
(
    SELECT
        CustomerID,
        CustomerName,
        SUM(SalesAmount) AS TotalSales
    FROM dbo.vw_FactSalesAnalysis
    GROUP BY
        CustomerID,
        CustomerName
)

SELECT
    CustomerID,
    CustomerName,
    TotalSales,
    NTILE(4) OVER
    (
        ORDER BY TotalSales DESC
    ) AS CustomerSegment
FROM CustomerSales
ORDER BY TotalSales DESC;


-- 2. Repeat vs One-Time Customers ---> How many customers purchased only once versus customers who purchased multiple times?
WITH CustomerOrders AS
(
    SELECT
        CustomerID,
        CustomerName,
        COUNT(DISTINCT SalesOrderID) AS TotalOrders
    FROM dbo.vw_FactSalesAnalysis
    GROUP BY
        CustomerID,
        CustomerName
)
SELECT
    CASE
        WHEN TotalOrders = 1
            THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS CustomerType,
    COUNT(*) AS NumberOfCustomers
FROM CustomerOrders
GROUP BY
    CASE
        WHEN TotalOrders = 1
            THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;


-- 3. Top 10 Customers by Total Profit ---> Which customers generate the highest profit?
SELECT TOP (10)
    CustomerID,
    CustomerName,
    SUM(SalesAmount) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM dbo.vw_FactSalesAnalysis
GROUP BY
    CustomerID,
    CustomerName
ORDER BY TotalProfit DESC;


-- 4. Customers with High Orders but Low Spending ---> Which customers place many orders but generate relatively low sales?
SELECT TOP (10)
    CustomerID,
    CustomerName,
    COUNT(DISTINCT SalesOrderID) AS TotalOrders,
    SUM(SalesAmount) AS TotalSales
FROM dbo.vw_FactSalesAnalysis
GROUP BY
    CustomerID,
    CustomerName
HAVING COUNT(DISTINCT SalesOrderID) >= 5
ORDER BY
    TotalOrders DESC,
    TotalSales ASC;












-- GEOGRAPHIC ANALYSIS


-- 1. Territory Contribution to Total Sales ---> What percentage of total sales comes from each territory?
SELECT
    Territory,
    SUM(SalesAmount) AS TotalSales,
    CAST
    (
        SUM(SalesAmount) * 100.0 /
        SUM(SUM(SalesAmount)) OVER ()
        AS DECIMAL(18,2)
    ) AS SalesContributionPercent
FROM dbo.vw_FactSalesAnalysis
GROUP BY Territory
ORDER BY TotalSales DESC;


-- 2. Territory Profit Margin ---> Which territories achieve the highest profit margin?
SELECT
    Territory,
    SUM(SalesAmount) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    CAST
    (
        SUM(Profit) * 100.0 /
        NULLIF(SUM(SalesAmount),0)
        AS DECIMAL(18,2)
    ) AS ProfitMarginPercent
FROM dbo.vw_FactSalesAnalysis
GROUP BY Territory
ORDER BY ProfitMarginPercent DESC;


-- 3. Best Performing Country ---> Which countries generate the highest sales?
SELECT
    CountryRegionCode,
    SUM(SalesAmount) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM dbo.vw_FactSalesAnalysis
GROUP BY CountryRegionCode
ORDER BY TotalSales DESC;


-- 4. Average Order Value by Territory ---> Which territories have the highest average order value?
SELECT
    Territory,
    SUM(SalesAmount) AS TotalSales,
    COUNT(DISTINCT SalesOrderID) AS TotalOrders,
    CAST
    (
        SUM(SalesAmount) /
        COUNT(DISTINCT SalesOrderID)
        AS DECIMAL(18,2)
    ) AS AverageOrderValue
FROM dbo.vw_FactSalesAnalysis
GROUP BY Territory
ORDER BY AverageOrderValue DESC;