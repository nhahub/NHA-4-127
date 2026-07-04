USE AdventureWorks2019;
GO

/*=========================================================
                PRODUCT ANALYSIS
=========================================================*/


/*---------------------------------------------------------
1. Top 10 Products by Sales
Business Question:
Which products generate the highest sales revenue?
---------------------------------------------------------*/

SELECT TOP (10)

    ProductName,

    SUM(SalesAmount) AS TotalSales

FROM dbo.vw_FactSalesAnalysis

GROUP BY ProductName

ORDER BY TotalSales DESC;

GO


/*---------------------------------------------------------
2. Bottom 10 Products by Sales
Business Question:
Which products generate the lowest sales revenue?
---------------------------------------------------------*/

SELECT TOP (10)

    ProductName,

    SUM(SalesAmount) AS TotalSales

FROM dbo.vw_FactSalesAnalysis

GROUP BY ProductName

ORDER BY TotalSales ASC;

GO


/*---------------------------------------------------------
3. Profit by Product Category
Business Question:
Which product categories generate the highest profit?
---------------------------------------------------------*/

SELECT

    Category,

    SUM(Profit) AS TotalProfit

FROM dbo.vw_FactSalesAnalysis

GROUP BY Category

ORDER BY TotalProfit DESC;

GO


/*---------------------------------------------------------
4. Sales by Product Subcategory
Business Question:
Which product subcategories generate the highest sales?
---------------------------------------------------------*/

SELECT

    Subcategory,

    SUM(SalesAmount) AS TotalSales

FROM dbo.vw_FactSalesAnalysis

GROUP BY Subcategory

ORDER BY TotalSales DESC;

GO


/*---------------------------------------------------------
5. Top 10 Products by Profit
Business Question:
Which products generate the highest profit?
---------------------------------------------------------*/

SELECT TOP (10)

    ProductName,

    SUM(Profit) AS TotalProfit

FROM dbo.vw_FactSalesAnalysis

GROUP BY ProductName

ORDER BY TotalProfit DESC;

GO


/*---------------------------------------------------------
6. Top 10 Products by Profit Margin
Business Question:
Which products achieve the highest profit margin?
---------------------------------------------------------*/

SELECT TOP (10)

    ProductName,

    SUM(SalesAmount) AS TotalSales,

    SUM(Profit) AS TotalProfit,

    ROUND(
        (SUM(Profit) * 100.0) /
        NULLIF(SUM(SalesAmount), 0),
        2
    ) AS ProfitMarginPercent

FROM dbo.vw_FactSalesAnalysis

GROUP BY ProductName

HAVING SUM(SalesAmount) > 0

ORDER BY ProfitMarginPercent DESC;

GO


/*---------------------------------------------------------
7. High Quantity - Low Profit Products
Business Question:
Which products sell in high quantities but generate
relatively low profit?
---------------------------------------------------------*/

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

GO










/*=========================================================
                CUSTOMER ANALYSIS
=========================================================*/


/*---------------------------------------------------------
1. Customer Segmentation
Business Question:
How can customers be segmented based on their total sales?
---------------------------------------------------------*/

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

GO


/*---------------------------------------------------------
2. Repeat vs One-Time Customers
Business Question:
How many customers purchased only once versus
customers who purchased multiple times?
---------------------------------------------------------*/

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

GO


/*---------------------------------------------------------
3. Top 10 Customers by Total Profit
Business Question:
Which customers generate the highest profit?
---------------------------------------------------------*/

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

GO


/*---------------------------------------------------------
4. Customers with High Orders but Low Spending
Business Question:
Which customers place many orders but generate
relatively low sales?
---------------------------------------------------------*/

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

GO












/*=========================================================
                GEOGRAPHIC ANALYSIS
=========================================================*/


/*---------------------------------------------------------
1. Territory Contribution to Total Sales
Business Question:
What percentage of total sales comes from each territory?
---------------------------------------------------------*/

SELECT

    Territory,

    SUM(SalesAmount) AS TotalSales,

    ROUND
    (
        SUM(SalesAmount) * 100.0 /
        SUM(SUM(SalesAmount)) OVER (),
        2
    ) AS SalesContributionPercent

FROM dbo.vw_FactSalesAnalysis

GROUP BY Territory

ORDER BY TotalSales DESC;

GO


/*---------------------------------------------------------
2. Territory Profit Margin
Business Question:
Which territories achieve the highest profit margin?
---------------------------------------------------------*/

SELECT

    Territory,

    SUM(SalesAmount) AS TotalSales,

    SUM(Profit) AS TotalProfit,

    ROUND
    (
        SUM(Profit) * 100.0 /
        NULLIF(SUM(SalesAmount),0),
        2
    ) AS ProfitMarginPercent

FROM dbo.vw_FactSalesAnalysis

GROUP BY Territory

ORDER BY ProfitMarginPercent DESC;

GO


/*---------------------------------------------------------
3. Best Performing Country
Business Question:
Which countries generate the highest sales?
---------------------------------------------------------*/

SELECT

    CountryRegionCode,

    SUM(SalesAmount) AS TotalSales,

    SUM(Profit) AS TotalProfit

FROM dbo.vw_FactSalesAnalysis

GROUP BY CountryRegionCode

ORDER BY TotalSales DESC;

GO


/*---------------------------------------------------------
4. Average Order Value by Territory
Business Question:
Which territories have the highest average order value?
---------------------------------------------------------*/

SELECT

    Territory,

    SUM(SalesAmount) AS TotalSales,

    COUNT(DISTINCT SalesOrderID) AS TotalOrders,

    ROUND
    (
        SUM(SalesAmount) /
        COUNT(DISTINCT SalesOrderID),
        2
    ) AS AverageOrderValue

FROM dbo.vw_FactSalesAnalysis

GROUP BY Territory

ORDER BY AverageOrderValue DESC;

GO