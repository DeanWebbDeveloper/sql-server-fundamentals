USE Hierarchy;

CREATE
TABLE			[personnel (parented)]
	(			[employee] INT IDENTITY PRIMARY KEY,
				[name] NVARCHAR (50),
				[hourly rate] MONEY,
				[boss] INT	--parent in personnel tree
	);


SET
IDENTITY_INSERT	dbo.[personnel (parented)]
ON;

INSERT
INTO			[personnel (parented)]
	(			[employee],
				[name],
				[hourly rate],
				[boss]
	)
VALUES
	(1,		'Big Boss',	1000.00,	1),
	(2,		'Joe',		10.00,		1),
	(8,		'Mary',		20.00,		1),
	(14,	'Jack',		15.00,		1),
	(3,		'Jane',		10.00,		2),
	(5,		'Max',		35.00,		2),
	(9,		'Lynn',		15.00,		8),
	(10,	'Miles',	60.00,		8),
	(12,	'Sue',		15.00,		8),
	(15,	'June',		50.00,		14),
	(18,	'Jim',		55.00,		14),
	(19,	'Bob',		40.00,		14),
	(4,		'Jayne',	35.00,		3),
	(6,		'Ann',		45.00,		5),
	(7,		'Art',		10.00,		5),
	(11,	'Al',		70.00,		10),
	(13,	'Mike',		50.00,		12),
	(16,	'Marty',	55.00,		15),
	(17,	'Barb',		60.00,		15),
	(20,	'Bart',		1000.00,	19);
	
SET
IDENTITY_INSERT	dbo.[personnel (parented)]
OFF;


SELECT			*
FROM			[personnel (parented)]
ORDER BY		[boss];

ALTER TABLE		[personnel (parented)]
ADD				[node] HIERARCHYID;

-- fills all nodes

WITH					sibs
AS
	(SELECT				[boss],
						[employee],
	CAST (row_number() OVER (PARTITION BY [boss] ORDER BY [employee])AS VARCHAR) + '/' AS sib
	FROM [personnel (parented)]
	WHERE employee != [boss]
	)
	
-- select * from sibs
, [no node]
AS
(SELECT [boss], [employee], HIERARCHYID::GetRoot() AS [node] FROM [personnel (parented)]
WHERE employee = boss
UNION ALL
SELECT P.boss, P.employee, CAST([no node].node.ToString() + sibs.sib AS HIERARCHYID AS node
FROM [personnel (parenteD)] AS P
JOIN [no node] ON P.boss = [no node].employee
JOIN sibs ON
P.employee = sibs.employee
)
--SELECT node.ToString(), * FROM [no node]

UPDATE			[personnel (parented)]
SET				node = [no node].node
FROM			[personnel (parented)]
AS				P JOIN [no node]
ON				P.employee = [no node].[employee]

SELECT			[node].ToString(),
				*
FROM			[personnel (parented)]
ORDER BY		[boss]