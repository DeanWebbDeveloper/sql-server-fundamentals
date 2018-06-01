USE securityII

CREATE DATABASE Context

ALTER AUTHORIZATION ON database::Context TO [--comp--\--user--]

USE Context



CREATE TABLE tests
(
	[id]		INT,
	[location]	VARCHAR(MAX)
)

SELECT * FROM tests

CREATE user [---comp---\---another user---]

GRANT SELECT ON tests TO [---comp---\---another user---]


EXECUTE AS login = '---com---\---user---'

SELECT * FROM sys.fn_my_permissions('tests', 'objects')

REVERT


EXECUTE AS user = '---comp---\---another user---'

SELECT * FROM sys.fn_my_permissions('tests', 'objects')

REVERT


USE securityII

EXECUTE AS user = '---comp---\---another user---'

SELECT * FROM Context.dbo.tests

REVERT


EXECUTE AS LOGIN = '---comp---\---user---'

SELECT * FROM Context.dbo.tests

USE Context

SELECT * FROM tests

REVERT

USE securityII

REVERT






CREATE DATABASE ExecuteAs
GO
USE ExecuteAs

CREATE TABLE wormholes
(
	[id]	INT,
	[size]	VARCHAR(100)
)

CREATE USER [---another user---] FROM LOGIN [---comp---\---another user---]

EXECUTE AS user = 'workerbee'

INSERT INTO wormholes VALUES (1, 'big')

REVERT


CREATE PROC ShootMeAnAsteroid (@key INT, @size VARCHAR(50))
AS
INSERT INTO wormholes VALUES (@key, @size)


GRANT EXECUTE ON ShootMeAnAsteroid TO [---user---]

EXECUTE AS user = '---user---'

EXEC ShootMeAnAsteroid 1, 'big'

SELECT USER


REVERT

SELECT * FROM wormholes


CREATE PROC JustShootMe (@cmd NVARCHAR(MAX))
AS
EXEC sp_executesql @cmd


GRANT EXECUTE ON JustShootMe To [---another user---]

EXECUTE AS user = '---another user---'

EXEC JustShootMe 'INSERT INTO wormholes VALUES (2, ''bigger'')'

REVERT



CREATE PROC JustShootMe2 (@cmd NVARCHAR(MAX))
WITH EXECUTE AS self
AS
EXEC sp_executesql @cmd


GRANT EXECUTE ON JustShootMe2 To ---another user---


EXECUTE As user = '---another user---'

EXEC JustShootMe2 'INSERT INTO wormholes VALUES (2, ''bigger'')'

REVERT


SELECT * FROM wormholes