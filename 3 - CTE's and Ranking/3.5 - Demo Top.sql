-- big table
SELECT COUNT(*) FROM [big table];

SELECT * FROM [big table];


-- traditional top usage

SELECT TOP 10 * FROM [big table]
ORDER BY ROUND([net worth], 0);

--ties excluded by default

SELECT TOP 10 WITH ties * FROM [big table]
ORDER BY ROUND([net worth], 0);

SELECT TOP(CAST(RAND() * 10 AS INT)) * FROM [big table]
ORDER BY [net worth];

-- do delete in chinks to minimise max lock/resources
updateMore:
delete TOP(1000000) [big table]
if @@rowcount != 0
goto updateMore;

--this has been depracated
deleteMore:
SET @@rowcount = 1000000
DELETE [big table]
IF @@rowcount != 0
goto deleteMore;