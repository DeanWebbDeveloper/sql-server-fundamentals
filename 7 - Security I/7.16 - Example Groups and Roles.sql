CREATE DATABASE	authority

SELECT			*
FROM			sys.fn_my_permissions(null,'server')

GRANT CONTROL SERVER TO [---comp---\---user---]


USE				authority

SELECT			*
FROM			sys.fn_my_permissions(null, 'database')

CREATE TABLE	[numbers]
(
	[number] INT
)

SELECT			*
FROM			sys.fn_my_permissions('numbers', 'object')		

INSERT INTO		[numbers]
VALUES			(1)

SELECT			*
FROM			[numbers]



CREATE USER		--name--
FROM LOGIN		[---comp---/---user---]

SELECT			*
FROM			sys.database_principals

SETUSER			--name--


--using sysadmin--

USE				[authority]

SETUSER			'--user--'

SELECT			*
FROM			numbers

SELECT			user

SETUSER			'--user--'

SETUSER



CREATE LOGIN	[---comp---\---group---]
FROM			windows

CREATE user		[---groupname---]
FROM LOGIN		[---comp---\---group---]

SELECT			*
FROM			sys.database_principals

GRANT			SELECT
ON				OBJECT::numbers
TO				[---groupname---]



CREATE ROLE		pilot

sp_addrolemember '---role---', '---user---'

GRANT			INSERT
ON				OBJECT::numbers
TO				[---role---]

SETUSER [---user---]

INSERT INTO		numbers
VALUES			(3)

SELECT * FROM sys.fn_my_permissions('numbers', 'object')