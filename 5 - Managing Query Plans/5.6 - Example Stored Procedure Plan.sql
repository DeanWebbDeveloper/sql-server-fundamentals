USE AdventureWorks2017;

dbcc freeproccache

exec dbo.uspLogError 10;

exec dbo.usplogerror 10;

SELECT			*
FROM			PlanCache;

SELECT			routine_definition
FROM			Information_schema.routines
WHERE			specific_name='uspLogError';

SELECT			COUNT(*)
FROM			Sales.Customer;

SELECT			COUNT(*)
FROM			Sales.Customer;

SELECT			*
FROM			PlanCache;


SELECT			COUNT(*)
FROM			Person.Address;
SELECT			COUNT(*)
FROM			Production.Product;


SELECT			COUNT(*)
FROM			Person.Address;
GO
SELECT			COUNT(*)
FROM			Production.Product;


SELECT			*
FROM			PlanCache;