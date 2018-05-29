USE AdventureWorks2017;

exec sp_control_plan_guide @operation='drop all';

CREATE PROC AllCustProd
AS
SELECT * FROM Person.Person;
SELECT * FROm Production.Product;

dbcc freeproccache;

exec AllCustProd;

SELECT * FROM PlanCache;

exec sp_create_plan_guide
@name = N'Fast9Proc',
@stmt = N'SELECT * FROM Person.Person',
@type = N'OBJECT',
@module_or_batch = N'AllCustProd',
@params=null,
@hints = 'OPTION (FAST 9)';

dbcc freeproccache;

exec AllCustProd;

SELECT * FROM PlanCache;