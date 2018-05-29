USE AdventureWorks2017;

dbcc freeproccache;

SELECT * FROM Sales.SalesOrderDetail;
SELECT * FROM Production.Product;

SELECT * FROM PlanCache;

SELECT * FROM Sales.SalesOrderDetail OPTION (FAST 9);
SELECT * FROM Production.Product;

exec sp_create_plan_guide
@name = N'FAST9',
@stmt = N'SELECT * FROM Sales.SalesOrderDetail',
@type = N'SQL',
@module_or_batch = N'SELECT * FROM Sales.SalesOrderDetail;
SELECT * FROM Production.Product;',
@params=null,
@hints = 'OPTION (FAST 9)';

exec sp_create_plan_guide
@name = N'FAST9',
@stmt = N'SELECT * FROM Sales.SalesOrderDetail',
@type = N'SQL',
@module_or_batch = N'SELECT * FROM Sales.SalesOrderDetail;
SELECT * FROM Production.Product;',
@params=null,
@hints =null;