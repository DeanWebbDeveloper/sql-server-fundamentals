-- hierarchyid as a number path
DECLARE @hid HIERARCHYID;
SET @hid = '/1/2/3/4/';
SELECT @hid, @hid.ToString();

-- syntax depends on final /
DECLARE @hid HIERARCHYID;
SET @hid = '/1/2/3/4';

-- sorting hierarchyid's
-- msd radix sort
DECLARE @hid1 HIERARCHYID;
DECLARE @hid2 HIERARCHYID;
SET @hid1 = '/1/2/3/1/';
SET @hid2 = '/1/2/2/4/';
SELECT hid.ToString() FROM
	(SELECT @hid1 AS hid
	UNION
	SELECT @hid2 AS hid) AS a
	ORDER BY hid;
	
-- adding length produces breadth first sort
DECLARE @hid1 HIERARCHYID;
DECLARE @hid2 HIERARCHYID;
SET @hid1 = '/1/2/2/1/';
SET @hid1 = '/1/1/2/1/2/';
SELECT hid.ToString() FROM
	(SELECT 4 AS len, @hid1 as hid
	UNION SELECT 5 as len, @hid as hid) AS a
	ORDER BY len, hid;



CREATE
TABLE			[personnel (small)]
(
[employee]		INT IDENTITY PRIMARY KEY,
[name]			NVARCHAR(50),
[hourly rate]	MONEY,
[node]			HIERARCHYID
);

INSERT
INTO			[personnel (small)]
				([name],		[hourly rate],	[node])
VALUES			('Big Boss',	1000,			'/'),
				('Joe',			10,				'/1/'),
				('Mary',		20,				'/2/'),
				('Jack',		15,				'/3/'),
				('Jane',		10,				'/1/1/'),
				('Max',			35,				'/1/2/'),
				('Lynn',		15,				'/2/1/'),
				('Miles',		60,				'/2/2/'),
				('Sue',			15,				'/2/3/'),
				('June',		50,				'/3/1/'),
				('Jim',			55,				'/3/2/'),
				('Bob',			40,				'/3/3/'),
				('Jayne',		35,				'/1/1/1/'),
				('Ann',			45,				'/1/2/1/'),
				('Art',			10,				'/1/2/2/'),
				('Al',			70,				'/2/2/1/'),
				('Mike',		50,				'/2/3/1/'),
				('Marty',		55,				'/3/1/1/'),
				('Barb',		60,				'/3/1/2/'),
				('Bart',		1000,			'/3/3/1/');
				
SELECT * FROM [personnel (small)];

SELECT node.ToString(), * FROM [PERSONNEL (small)];

SELECT P.node.ToString() AS node, P.name, P2.name AS boss
FROM [personnel (small)] as P
JOIN [personnel (small)] as P2
ON P2.node.ToString() = LEFT(P.node.ToString(),
	LEN(P.node.ToString()) + 1 -
		CHARINDEX('/', REVERSE(P.node.ToString()),2 ));