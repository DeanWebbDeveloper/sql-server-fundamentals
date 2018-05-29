USE AdventureWorks2017;

dbcc freeproccache

ALTER DATABASE AdventureWorks2017 SET parameterization simple;

SELECT * FROM Production.Product WHERE ProductID > 10;

SELECT * FROM PlanCache;

DECLARE @s nvarchar(max);
DECLARE @p nvarchar(max);
exec sp_get_query_template N'SELECT * FROM Production.Product WHERE ProductID > 10;', @s output, @p output;
SELECT @s, @p

select * from Production . Product where ProductID > @0
@0 int

EXEC sp_create_plan_guide
@name = N'ParamProduct',
@module_or_batch = null,
@stmt = N'SELECT * FROM Production.Product WHERE ProductID > @0',
@type= N'TEMPLATE',
@hints = N'OPTION(parameterization forced)',
@params = N'@0 int';