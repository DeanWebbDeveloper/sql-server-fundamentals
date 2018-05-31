CREATE DATABASE	[security principals];
GO
USE				[security principals];

SELECT			*
FROM			sys.server_principals

CREATE LOGIN	DoNotDoThis
WITH PASSWORD	= 'password'

CREATE LOGIN	[---comp---\---user---]  --not so friendly in windows 10 due to nature of login
FROM			windows