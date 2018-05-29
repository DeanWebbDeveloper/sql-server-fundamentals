USE AdventureWorks2017;

dbcc freeproccache

CREATE procedure GreaterProducts(@id int)
AS
SELECT * FROM Production.Product WHERE ProductId>@id
OPTION (OPTIMIZE FOR (@id = 9));

exec GreaterProducts 4;

SELECT * FROM PlanCache;

exec sp_create_plan_guide
@name = N'P9',
@stmt = N'SELECT * FROM Production.Product WHERE ProductID>@id',
@type = N'OBJECT',
@module_or_batch = N'GreaterProducts',
@params = null,
@hints = 'OPTION (OPTIMIZE FOR (@id = 9))';
