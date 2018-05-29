USE AdventureWorks2017;

SELECT Databasepropertyex ('AdventureWorks2017', 'IsParameterizationForced');

dbcc freeproccache;

SELECT * FROM PlanCache;

SELECT * FROM Production.Product WHERE ProductID = 4;

SELECT * FROM Production.Product WHERE ProductID = 5;

SELECT COUNT(*) FROM Production.Product WHERE ProductID > 5

ALTER DATABASE AdventureWorks2017 SET parameterization forced;

ALTER DATABASE AdventureWorks2017 SET parameterization simple;

SELECT * FROM PlanCache;

sp_executesql N'SELECT COUNT(*) FROM Production.Product WHERE ProductID > @pid', N'@pid int', 5;