USE Hierarchy;

UPDATE			[personnel (parented)]
SET				node = null;

--incremental fill
WITH			[sibs]
AS
	(SELECT		[boss],
				[employee],
				CAST(row_number() OVER (PARTITION BY [boss] ORDER BY [employee]) AS VARCHAR) + '/' AS sib
				FROM [personnel (parented)]
				WHERE EMPLOYEE != [boss]
				)
				
				-- SELECT * FROM [sibs]
,[no node]
AS
	(SELECT P2.node.ToString() + sibs.sib AS node, P1.employee,
			P1.boss
	FROM	[personnel (parented)] AS P1
	JOIN	[personnel (parented)] AS P2
	ON		P2.employee = P1.boss
	JOIN	sibs
	ON		P1.employee = sibs.employee
	WHERE	P2.node IS NOT NULL
	AND		P1.employee != P1.boss
	AND		P1.node IS NULL
	UNION
	SELECT	'/'	AS node, P1.employee, P1.boss FROM [personnel (parented)] AS P1
	WHERE	P1.employee = P1.boss AND P1.node IS NULL
	UNION ALL
	SELECT	[no node].node + sibs.sib AS [node],
			P.employee, P.boss
	FROM	[personnel (parented)]
	AS		P
	JOIN	[no node]
	ON		[no node].employee = P.boss
	JOIN	sibs
	ON		sibs.employee = P.employee
	WHERE	P.employee != P.boss
	)
--SELECT * FROM [no node]
					
UPDATE
TOP(3)		[personnel (parented)]
SET			node = [no node].node
FROM		[personnel (parented)] AS P JOIN [no node]
ON			P.employee = [no node].employee;

SELECT		[node].ToString(),
			*
FROM		[personnel (parented)]