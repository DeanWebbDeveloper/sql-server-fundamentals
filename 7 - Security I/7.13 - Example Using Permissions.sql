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