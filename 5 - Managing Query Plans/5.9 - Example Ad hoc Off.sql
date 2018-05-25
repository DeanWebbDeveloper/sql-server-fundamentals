dbcc freeproccache

SELECT			COUNT(*)
FROM			SalesLT.Customer;

SELECT			*
FROM			PlanCache

SELECT			COUNT(*)
FROM			SalesLT.Product;

sp_configure 'show advanced options', 0;
GO
RECONFIGURE
GO
sp_configure 'optimize for ad hoc workloads', 0;
GO
RECONFIGURE