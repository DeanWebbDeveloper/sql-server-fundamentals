CREATE DATABASE		securityII
GO
USE					securityII

SELECT				*
FROM				securityII.sys.schemas

SELECT				*
FROM				sys.schemas

SELECT				s.*, p.name
FROM				sys.schemas
AS					s
JOIN				sys.database_principals
AS					p
ON					s.principal_id = p.principal_id

SELECT				USER

CREATE USER			nologin
WITHOUT				login

CREATE USER			[---username---]
FROM LOGIN			[---comp---\---user---]

CREATE USER			[---username---]
FROM LOGIN			[---comp---\---user---]
WITH default_schema	= [---schema name---]

SELECT				*
FROM				sys.database_principals
WHERE				name
IN					(--specify names of users--
					)
					
ALTER USER			[---name--]
WITH default_schema = 'saucer'

SELECT				*
FROM				sys.fn_my_permissions('securityII', 'database')

CREATE SCHEMA		[saucer]
CREATE TABLE		[planets]
(
	[id]	INT PRIMARY KEY,
	[name]	VARCHAR(50)
)
CREATE TABLE		[stars]
(
	[id]	INT PRIMARY KEY,
	[name]	VARCHAR(50)
)
CREATE VIEW			[places]
AS
	SELECT			[id], [name]
	FROM			[planets]
UNION
	SELECT			[id], [name]
	FROM			[stars]
UNION
	SELECT			[id], [name]
	FROM			[comets]


SELECT				*
FROM				sys.schemas
WHERE				[name] = 'saucer'


CREATE SCHEMA		[saucer]
CREATE TABLE		[planets]
(
	[id]	INT PRIMARY KEY,
	[name]	VARCHAR(50)
)
CREATE TABLE		[stars]
(
	[id]	INT PRIMARY KEY,
	[name]	VARCHAR(50)
)
CREATE TABLE		[comets]
(
	[id]	INT PRIMARY KEY,
	[name]	VARCHAR(50)
)
CREATE VIEW			[places]
AS
	SELECT			[id], [name]
	FROM			[planets]
UNION
	SELECT			[id], [name]
	FROM			[stars]
UNION
	SELECT			[id], [name]
	FROM			[comets]
	
SELECT				*
FROM				sys.tables


SELECT				o.name
FROM				sys.objects
AS					o
JOIN				sys.schemas
AS					s
ON					o.schema_id = s.schema_id
WHERE				s.name = 'saucer'

SELECT				*
FROM				[saucer].[planets]

SELECT				*
FROM				[planets]

--equal to if default is dbo

SELECT				*
FROM				[dbo].[planets]


SETUSER				'[--user--]'
SELECT				USER


SETUSER
SELECT				USER


EXECUTE AS			user = '[--name--]'
SELECT				USER

REVERT

EXECUTE AS			user = '[--name--]'  --WHERE user has default of 'saucer'


SELECT				*
FROM				[planets]

SELECT				*
FROM				[saucer][planets]


REVERT

GRANT
SELECT ON			[saucer].[planets]
TO					[---user---]


sp_help 'planets'	--works if default is set correctly

REVERT


sp_help 'saucer.planets'


CREATE SCHEMA		[dangers]
AUTHORIZATION		[---user---]
CREATE TABLE		[bad_planets]
(
	[id]	INT PRIMARY KEY,
	[name]	VARCHAR(50)
)


SELECT				p.name, s.*
FROM				sys.schemas
AS					s
JOIN				sys.database_principals
AS					p
ON					s.principal_id = p.principal_id
WHERE				s.name = 'dangers'


EXECTUTE AS			user = '[--name--]'

SELECT				*
FROM				sys.fn_my_permissions('dangers', 'schema')

CREATE TABLE		[dangers].[status]
(
	[i]		INT PRIMARY KEY,
	[level]	VARCHAR(50)
)


REVERT


GRANT CREATE TABLE TO [---user---]

CREATE TABLE		[dangers].[status]
(
	[i]		INT PRIMARY KEY,
	[level]	VARCHAR(50)
)

EXECUTE AS user = '[--different name--]'

SELECT * FROM danger.bad_planets


REVERT

EXECUTE AS user = '[---user---]'

GRANT
SELECT ON			[dangers].[bad_planets]
TO					[---another user---]

REVERT
