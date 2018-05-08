USE CTERankingPartitioning

SELECT * FROM [employees]

SELECT [first name], [last name], [base rate],
RANK() OVER (ORDER BY [base rate]) AS rank
FROM [employees]
ORDER BY rank

-- partitioned by family
SELECT [first name], [last name], [base rate],
RANK() OVER (PARTITION BY [last name] ORDER BY [base rate]) AS rank
FROM [employees]
ORDER BY [last name], rank DESC;

-- works with ntile
SELECT [first name], [last name], [base rate],
NTILE(4) OVER (PARTITION BY [last name] ORDER BY [base rate]) AS quartile
FROM [employees]
ORDER BY [last name], quartile;