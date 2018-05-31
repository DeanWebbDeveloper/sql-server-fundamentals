CREATE DATABASE	[security principals];
GO
USE				[security principals];

SELECT			*
FROM			sys.server_principals

CREATE LOGIN	DoNotDoThis
WITH PASSWORD	= 'password'

CREATE LOGIN	[---comp---\---user---]
FROM			windows

SELECT			*
FROM			[security principals].sys.database_principals

SELECT			*
FROM			[model].sys.database_principals

CREATE USER		[---comp---\---user---]

--sid--

CREATE USER		dean
FROM LOGIN		[---comp---\---user---]

SELECT			*
FROM			sys.server_principals
WHERE			sid = ---sid---

ALTER USER		[---comp---\---user---]
WITH			name = deanwebbdeveloper

CREATE USER		whoami
WITHOUT			login

DROP USER		whoami

CREATE ROLE		myrole