SELECT * FROM [employees];

-- just ranking according to base rate
SELECT [first name], [last name], [base rate],
row_number() OVER (ORDER BY [base rate] DESC)
FROM [employees];

-- rank according to rounded base rate
SELECT [first name], [last name], ROUND([base rate], 0),
row_number() OVER (ORDER BY ROUND([base rate], 0) DESC)
FROM [employees];
 
 -- mixing ranks
SELECT [first name], [last name], ROUND([base rate], 0),
row_number() OVER (ORDER BY ROUND([base rate], 0)DESC) As rate_rank,
row_number() OVER (ORDER BY [location]) AS location_rank
FROM employees;

-- try to page through employees
SELECT [first name], [last name], [base rate],
row_number() OVER (ORDER BY [base rate] DESC) AS rn
FROM [employees] WHERE rn BETWEEN 5 AND 10;

-- use CTE to enable paging
WITH rn
AS
(SELECT [id], row_number() OVER (ORDER BY [base rate] DESC) AS rn
FROM [employees]
)
SELECT [first name], [last name], [base rate], rn FROM
[employees] JOIN rn on [employees].[id] = rn.[id]
WHERE rn BETWEEN 5 AND 10;

-- useful, can put it in a function to call again

-- can be wrapped into a function

CREATE FUNCTION getEmployeePage(@page INT, @pageSize INT)
RETURNS TABLE
AS
RETURN
WITH rn
AS
(SELECT [id], row_number() OVER (ORDER BY [base rate] DESC) AS rn
FROM [employees]
)
SELECT [first name], [last name], [base rate], rn FROM
[employees] JOIN rn ON [employees].[id] = rn.[id]
WHERE rn BETWEEN (@page - 1) * @pageSize AND (@page * @pageSize);

-- then get page
SELECT * FROM [dbo].getEmployeePage(1, 25);