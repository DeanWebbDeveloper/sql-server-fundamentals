USE AdventureWorks2017;

SELECT * FROM sys.plan_guides;

dbcc freeproccache;

SELECT * FROM Sales.SalesOrderDetail;
SELECT * FROM Production.Product;

SELECT * FROM PlanCache;

sp_control_plan_guide
@operation= N'disable',
@name = N'FAST9'

sp_control_plan_guide
@operation = N'enable',
@name = N'FAST9'

exec sp_create_plan_guide
@name = N'FAST5',
@stmt = N'SELECT * FROM Sales.SalesOrderDetail',
@type = N'SQL',
@module_or_batch = N'SELECT * FROM Sales.SalesOrderDetail;
SELECT * FROM Production.Product;',
@params=null,
@hints = 'OPTION (FAST 5)';

sp_control_plan_guide
@operation = N'disable',
@name = N'FAST9'

sp_control_plan_guide
@operation = N'disable',
@name = N'FAST9'

sp_control_plan_guide
@operation = N'disable all'

sp_control_plan_guide
@operation = N'drop all'