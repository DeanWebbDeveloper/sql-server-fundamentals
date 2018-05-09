USE CTERankingPartitioning;

SELECT * FROM [employees];

-- doesn't work
SELECT [last name], [first name],
[base rate] - AVG([base rate]) AS [rate diff] FROM [employees];

-- traditional group by
SELECT [last name], [first name],
[base rate] - AVG([base rate]) AS [rate diff] FROM [employees]
GROUP BY [last name], [first name], [base rate];

-- aggregate partition
SELECT [last name], [first name],
[base rate] - AVG([base rate]) OVER (PARTITION BY [last name])
AS [rate diff] FROM [employees]
ORDER BY [last name], [rate diff];

-- degenerate case
SELECT [last name], [first name],
[base rate] - AVG([base rate]) OVER (PARTITION BY 0)
AS [rate diff] FROM [employees]
ORDER BY [rate diff];

-- working with table wide stats
SELECT [first name], [last name], [base rate],
(([base rate] - avg(([base rate]) OVER (PARTITION BY 0)) /
(STDEV([base rate]) OVER (PARTITION BY 0))
AS diff
FROM employees;