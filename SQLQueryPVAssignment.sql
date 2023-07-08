--QUESTION 1:

SELECT Color, StandardCost AS Price
FROM DimProduct
WHERE StandardCost IS NOT NULL AND Color IS NOT NULL AND Color NOT IN ('Silver', 'Black', 'White', 'NA')
ORDER BY ListPrice DESC


--QUESTION 2:

SELECT FirstName, LastName, Gender, BirthDate, HireDate
FROM DimEmployee
WHERE
	Gender = 'M' AND BirthDate BETWEEN '1962-01-01' AND '1970-12-31' AND HireDate > '2001-12-31'
	OR
	Gender = 'F' AND BirthDate BETWEEN '1972-01-01' AND '1975-12-31' AND HireDate BETWEEN '2001-01-01' AND '2002-12-31'
ORDER BY HireDate ASC



--QUESTION 3:

SELECT *
from DimProduct

SELECT TOP (10) StandardCost, ProductAlternateKey, EnglishProductName, Color
FROM DimProduct
WHERE ProductAlternateKey LIKE 'BK%'
GROUP BY ProductAlternateKey, EnglishProductName, Color, StandardCost
ORDER BY StandardCost DESC


--QUESTION 4:

SELECT * FROM DimEmployee

--Q4i

SELECT FirstName, LastName, EmailAddress, EmergencyContactName
FROM DimEmployee
WHERE LEFT(LastName,4) = LEFT(EmailAddress,4)

--Q4ii

SELECT FirstName, LastName, EmailAddress, EmergencyContactName
FROM DimEmployee
WHERE LEFT(FirstName,1) = LEFT(LastName,1)

--Q4iii

SELECT FirstName, LastName, EmailAddress, EmergencyContactName, FirstName + ' ' + LastName AS FullName
FROM DimEmployee
WHERE LEFT(FirstName,1) = LEFT(LastName,1)


--QUESTION 5:

SELECT * FROM DimProductSubcategory
SELECT * FROM DimProduct

SELECT EnglishProductSubcategoryName
FROM DimProductSubcategory AS PS
INNER JOIN DimProduct AS P
ON PS.ProductSubcategoryKey = P.ProductSubcategoryKey
WHERE P.DaysToManufacture >= 3


--QUESTION 6:

SELECT EnglishProductName,
		ListPrice,
		CASE WHEN ListPrice < 200 THEN 'Low Value'
			WHEN ListPrice BETWEEN 201 AND 750 THEN 'Mid Value'
			WHEN ListPrice BETWEEN 751 AND 1250 THEN 'Mid to High Value'
			ELSE 'High Value' END AS PriceSegmentation
FROM DimProduct
WHERE Color IN ('Black', 'Silver', 'Red') AND ListPrice IS NOT NULL


--QUESTION 7:

SELECT * FROM DimEmployee

SELECT COUNT(DISTINCT(Title)) AS DistinctTitles
FROM DimEmployee


--QUESTION 8:

SELECT FirstName, LastName, DATEDIFF(YEAR, BirthDate, HireDate) AS EmployeeAge
FROM DimEmployee


--QUESTION 9:

SELECT FirstName,
		LastName,
		DATEDIFF(YEAR, StartDate, GETDATE()) AS TotalYearsServedNow,
		DATEDIFF(YEAR, StartDate, DATEADD(YEAR, 5, GETDATE())) AS TotalYearsServedIn5Years,
CASE WHEN DATEDIFF(YEAR, StartDate, DATEADD(YEAR, 5, GETDATE())) >= 20
	THEN 'Due'
	ELSE 'NotDue'
	END AS LongServiceAwardIn5Years
FROM DimEmployee


--QUESTION 10:

SELECT * FROM DimEmployee

DECLARE @RetirmentAge AS INT
SET @RetirmentAge = 65

SELECT FirstName,
		LastName,
		DATEDIFF(YEAR, BirthDate, GETDATE()) AS CurrentAge,
		@RetirmentAge - DATEDIFF(YEAR, BirthDate, GETDATE()) AS YearsToRetirement,
		CASE WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) >= @RetirmentAge THEN 'Retired'
		ELSE 'Not Retired' END AS RetirementStatus
FROM DimEmployee


--QUESTION 11: UNDONE

SELECT Color, ListPrice FROM DimProduct WHERE Color = 'Silver/Black'

SELECT EnglishProductName, StandardCost, Color,
		CASE WHEN Color = 'White' THEN StandardCost * 1.08
		WHEN Color = 'Yellow' THEN StandardCost * 0.925
		WHEN Color = 'Black' THEN StandardCost * 1.172
		WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN (SQRT(StandardCost)) * 2
		ELSE 'N/A' END AS NewPrice,
		CASE WHEN Color = 'White' THEN (StandardCost * 1.08) * 0.375
		WHEN Color = 'Yellow' THEN (StandardCost * 0.925) * 0.375
		WHEN Color = 'Black' THEN (StandardCost * 1.172) * 0.375
		WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN ((SQRT(StandardCost)) * 2) * 0.375
		ELSE 'N/A' END AS Commission
FROM DimProduct


SELECT EnglishProductName, ListPrice, Color,
		CASE WHEN Color = 'White' THEN ListPrice * 1.08
		WHEN Color = 'Yellow' THEN ListPrice * 0.925
		WHEN Color = 'Black' THEN ListPrice * 1.172
		WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN (SQRT(ListPrice)) * 2
		ELSE 'N/A' END AS NewPrice,
		CASE WHEN Color = 'White' THEN (ListPrice * 1.08) * 0.375
		WHEN Color = 'Yellow' THEN (ListPrice * 0.925) * 0.375
		WHEN Color = 'Black' THEN (ListPrice * 1.172) * 0.375
		WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN ((SQRT(ListPrice)) * 2) * 0.375
		ELSE 'N/A' END AS Commission
FROM DimProduct

SELECT EnglishProductName, ListPrice, Color,
		CASE WHEN Color = 'White' THEN TRY_CONVERT(NUMERIC(8,4),ListPrice) * 1.08
		WHEN Color = 'Yellow' THEN TRY_CONVERT(NUMERIC(8,4),ListPrice) * 0.925
		WHEN Color = 'Black' THEN TRY_CONVERT(NUMERIC(8,4),ListPrice) * 1.172
		WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN TRY_CONVERT(NUMERIC(8,4),ListPrice) * 2
		ELSE 'N/A' END AS NewPrice
FROM DimProduct

SELECT EnglishProductName, ListPrice, Color,
		CASE WHEN Color = 'White' THEN CONVERT(SMALLMONEY,ListPrice) * 1.08
		WHEN Color = 'Yellow' THEN CONVERT(SMALLMONEY,ListPrice) * 0.925
		WHEN Color = 'Black' THEN CONVERT(SMALLMONEY,ListPrice) * 1.172
		WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN CONVERT(SMALLMONEY,ListPrice) * 2
		ELSE 'N/A' END AS NewPrice
FROM DimProduct


SELECT EnglishProductName, ListPrice, Color,
		CASE WHEN Color = 'White' THEN TRY_CONVERT(SMALLMONEY,ListPrice) * 1.08
		WHEN Color = 'Yellow' THEN TRY_CONVERT(SMALLMONEY,ListPrice) * 0.925
		WHEN Color = 'Black' THEN TRY_CONVERT(SMALLMONEY,ListPrice) * 1.172
		WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN TRY_CONVERT(SMALLMONEY,ListPrice) * 2
		ELSE 'N/A' END AS NewPrice
FROM DimProduct

DECLARE @NewPrice AS SMALLMONEY
SELECT @NewPrice AS NewPrice

SELECT EnglishProductName, ListPrice, Color,
		CASE WHEN Color = 'White' THEN ListPrice * 1.08
		WHEN Color = 'Yellow' THEN ListPrice * 0.925
		WHEN Color = 'Black' THEN ListPrice * 1.172
		WHEN Color IN ('Multi', 'Silver', 'Silver/Black', 'Blue') THEN (SQRT(ListPrice)) * 2
		ELSE 'N/A' END AS NewPrice,
		@NewPrice * 0.375 AS Commission
FROM DimProduct




--QUESTION 12:

SELECT E.FirstName, E.LastName, E.HireDate, E.SickLeaveHours, ST.SalesTerritoryRegion, SQ.SalesAmountQuota
FROM DimEmployee AS E
LEFT JOIN FactSalesQuota AS SQ
ON E.EmployeeKey = SQ.EmployeeKey
LEFT JOIN DimSalesTerritory AS ST
ON E.SalesTerritoryKey = ST.SalesTerritoryKey
WHERE DepartmentName = 'Sales'


--QUESTION 13:

SELECT P.EnglishProductName, PC.EnglishProductCategoryName, PSC.EnglishProductSubcategoryName,
E.FirstName, E.LastName, FIS.SalesAmount,
DATENAME(MONTH,FIS.OrderDate) AS TransactionMonth, 'Q' + CONVERT(VARCHAR(20),DATEPART(QUARTER,FIS.OrderDate)) AS TransactionQuarter,
ST.SalesTerritoryRegion
FROM DimProduct AS P
LEFT JOIN DimProductSubcategory AS PSC
ON P.ProductSubcategoryKey = PSC.ProductSubcategoryKey
LEFT JOIN DimProductCategory AS PC
ON PSC.ProductCategoryKey = PC.ProductCategoryKey
LEFT JOIN FactInternetSales AS FIS
ON P.ProductKey = FIS.ProductKey
LEFT JOIN DimEmployee AS E
ON FIS.SalesTerritoryKey = E.SalesTerritoryKey
LEFT JOIN DimSalesTerritory AS ST
ON E.SalesTerritoryKey = ST.SalesTerritoryKey
WHERE E.DepartmentName = 'Sales'



--QUESTION 14: UNDONE

SELECT FIS.SalesOrderNumber, FIS.OrderDate, FIS.OrderQuantity, FIS.SalesAmount,
C.FirstName AS CustomerFirstName, C.LastName AS CustomerLastName,
E.FirstName AS SalesmanFirstName, E.LastName AS SalesmanlastName
FROM FactInternetSales AS FIS
LEFT JOIN DimCustomer AS C
ON FIS.CustomerKey = C.CustomerKey
LEFT JOIN DimEmployee AS E
ON FIS.SalesTerritoryKey = E.SalesTerritoryKey



--QUESTION 15:

SELECT EnglishProductName, Color, StandardCost, 0.1479 * StandardCost AS Commission,
	CASE WHEN Color = 'Black' THEN StandardCost + 0.22
		WHEN Color = 'Red' THEN StandardCost - 0.12
		WHEN Color = 'Silver' THEN StandardCost + 0.15
		WHEN Color = 'Multi' THEN StandardCost + 0.05
		WHEN Color = 'White' THEN (StandardCost * 2) / SQRT(StandardCost)
		ELSE StandardCost END AS Margin
FROM DimProduct
WHERE StandardCost IS NOT NULL


--QUESTION 16:
GO
CREATE VIEW ViewByMostExpensiveProducts AS
SELECT TOP (5) EnglishProductName, StandardCost
FROM DimProduct
ORDER BY StandardCost DESC
GO

SELECT * FROM ViewByMostExpensiveProducts