SELECT * FROM [employees];

-- rank according to family name
SELECT [first name], [last name],
RANK() OVER (ORDER BY [last name]) AS rn
FROM employees;

-- dense rank according to family name
SELECT [first name], [last name],
DENSE_RANK() OVER (ORDER BY [last name]) AS drn,
RANK() OVER (ORDER BY [last name]) AS rn
FROM employees;
