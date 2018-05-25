dbcc freeproccache

exec dbo.uspLogError 10;

exec dbo.usplogerror 10;

SELECT			*
FROM			PlanCache;



SELECT			routine_definition
FROM			Information_schema.routines
WHERE			specific_name='uspLogError';

SELECT			COUNT(*)
FROM			SalesLT.Customer;

SELECT			COUNT(*)
FROM			saleslt.customer;

SELECT			*
FROM			PlanCache;


SELECT			COUNT(*)
FROM			SalesLT.Address;
SELECT			COUNT(*)
FROM			SalesLT.Product;


SELECT			COUNT(*)
FROM			SalesLT.Address;
GO
SELECT			COUNT(*)
FROM			SalesLT.Product;


SELECT			*
FROM			PlanCache;