USE AdventureWorks2017;

dbcc freeproccache

SELECT			COUNT(*)
FROM			Person.Person;

SELECT			*
FROM			PlanCache

SELECT			COUNT(*)
FROM			Production.Product;

sp_configure 'show advanced options', 0;
GO
RECONFIGURE
GO
sp_configure 'optimize for ad hoc workloads', 0;
GO
RECONFIGURE