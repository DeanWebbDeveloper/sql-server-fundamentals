USE					[Recursion etc];

CREATE				TABLE [personnel (parented)]
(
	[employee]		INT IDENTITY PRIMARY KEY,
	[name]			NVARCHAR(50),
	[hourly rate]	MONEY,
	[boss]			INT --parent in personnel tree
);

SET	IDENTITY_INSERT	dbo.[personnel (parented)] ON;
INSERT INTO			[personnel (parented)] ([employee], [name], [hourly rate], [boss])
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
SET IDENTITY_INSERT dbo.[personnel (parented)] OFF;

SELECT				*
FROM				[personnel (parented)]
ORDER BY			[boss]

-- employees in Mary's

DECLARE				@boss INT;
SET					@boss = 8; -- Mary

WITH tree
AS
(
	SELECT			[employee], [boss]				----------------
	FROM			[personnel (parented)]			----INITIALISING
	WHERE			employee = @boss				----------------
	UNION ALL
	SELECT			p.[employee], p.[boss]			----------------
	FROM			[personnel (parented)]			----------------
	AS				p								--RECURSIVE CALL
	JOIN			tree							----------------
	ON				tree.[employee] = p.[boss]		----------------
)
SELECT				p.*								----------------
FROM				[personnel (parented)]			----------------
AS					p								--RETURN RESULTS
JOIN				tree							----------------
ON					tree.[employee] = p.[employee]	----------------


-- hourly rate budget for Mary

DECLARE				@boss INT;
SET					@boss = 8;

WITH				tree
AS
(
	SELECT			[employee], [boss]
	FROM			[personnel (parented)]
	WHERE			[employee] = @boss
	UNION ALL
	SELECT			p.[employee], p.[boss]
	FROM			[personnel (parented)]
	AS				p
	JOIN			tree
	ON				tree.[employee] = p.[boss]
)
SELECT				SUM(p.[hourly rate])
AS					[hourly budget]
FROM				[personnel (parented)]
AS					p
JOIN				tree
ON					tree.employee = p.[employee]


-- wrap up tree selection into tvf

CREATE FUNCTION		PersonnelTree(@boss INT)
RETURNS				TABLE
AS
RETURN
WITH				tree
AS
(
	SELECT			[employee], [boss]
	FROM			[personnel (parented)]
	WHERE			[employee] = @boss
	UNION ALL
	SELECT			p.[employee], p.[boss]
	FROM			[personnel (parented)]
	AS				p
	JOIN			tree
	ON				tree.[employee] = p.[boss]
	AND				p.[employee] != p.[boss]
)
SELECT				*
FROM				tree


SELECT				p.*
FROM				[personnel (parented)]
AS					p
JOIN				PersonnelTree(12)
AS					tree
ON					p.employee = tree.[employee]