USE AdventureWorks2017;

dbcc freeproccache

SELECT * FROM Production.Product;
SELECT * FROM Person.Person;

SELECT * FROM sys.dm_exec_cached_plans
CROSS APPLY sys.dm_exec_sql_text(plan_handle);

-- plan handle 0x06000700DB2301359091350A1102000001000000000000000000000000000000000000000000000000000000

exec sp_create_plan_guide_from_handle @name = N'G1',
@plan_handle = 0x06000700DB2301359091350A1102000001000000000000000000000000000000000000000000000000000000--plan handle

SELECT * FROM sys.plan_guides