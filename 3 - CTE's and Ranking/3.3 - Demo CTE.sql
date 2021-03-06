USE CTERankingPartitioning;

SELECT * FROM [shifts];
SELECT * FROM [plant locations];

SELECT * FROM [employees];

-- trivial examples to illustrate syntax
WITH [locations]
AS
(SELECT [id], [state], [premium], [business sector] FROM [plant locations])
SELECT * FROM [locations];

WITH [locations] (plant, st, premium, sector)
AS
(SELECT [id], [state], [premium], [business sector] FROM [plant locations])
SELECT * FROM [locations];

-- find the net premium by shift, by plant
WITH [shift premiums]
AS
(SELECT [id], [premium] FROM [shifts]),

[local premiums] (shift, plant, premium)
AS
(SELECT sp.id, pl.id,
sp.premium * pl.premium
FROM [shift premiums] AS sp CROSS JOIN [plant locations] AS pl)

SELECT pl.name, lp.shift, lp.premium
FROM [plant locations] as pl JOIN [local premiums] AS lp
ON pl.id = lp.plant
ORDER BY pl.name, lp.shift;

-- calculate each employee pay relative to the
-- average pay of all employees in terms
-- of standard deviations

WITH [location shifts] (shift_id, plant_id, premium)
AS
(SELECT shifts.id, [plant locations].[id],
	[shifts].[premium] * [plant locations].[premium]
	FROM [shifts] CROSS JOIN [plant locations])
	
	--SELECT * FROM [location shifts]
	
	,

[employee rates] (id, rate) AS
(SELECT [employees].[id], [base rate] * [location shifts].[premium]
	FROM [employees] JOIN [location shifts]
	ON [employees].[location] = [location shifts].[plant_id]
	AND [employees].[shift] = [location shifts].[shift_id])
	
	--SELECT * FROM [employee rates]
	
	,
	
stats (stdev_rate, avg_rate) AS
(SELECT STDEV(rate), AVG(rate) FROM [employee rates])

SELECT [employees].[id], [employees].[first name], [employees].[last name],
([employee rates].[rate] - stats.avg_rate)/stats.stdev_rate
FROM employees JOIN [employee rates] on [employees].[id] = [employee rates].[id]
CROSS JOIN stats
ORDER BY [last name], [first name]