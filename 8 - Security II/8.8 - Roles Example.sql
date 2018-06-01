USE securityII

sp_helpsrvrole

sp_srvrolepermission	'sysadmin'

sp_srvrolepermission	'dbcreator'

SELECT					*
FROM					sys.server_principals
WHERE					type = 'r'

SELECT					*
FROM					sys.database_principals
WHERE					type = 'r'

SELECT					*
FROM					sys.server_principals
WHERE					name = 'sysadmin'

CREATE LOGIN			[---comp---\---user---]
FROM					windows


--check with the new user that has low permissions--

SELECT					*
FROM					sys.fn_my_permissions(null, 'server')



--change user to a sysadmin

sp_helpsrvrolemember 'sysadmin'

sp_addsrvrolemember '---comp---\---user---', 'sysadmin'


--check permissions have changed--

SELECT					*
FROM					sys.fn_my_permissions(null, 'server')


sp_dropsrvrolemember '---comp---\---user---', 'sysadmin'


sp_helpdbfixedrole

SELECT					*
FROM					sys.database_principals

CREATE USER				[---comp---\---user---]

EXECUTE as				user = '---comp---\---user---'

SELECT					*
FROM					saucer.planets

REVERT


sp_addrolemember 'db_datareader', '---comp---\---user---'

REVERT


DENY SELECT ON			schema::saucer
TO						db_datareader -- will not allow as fixed roles cannot eb altered

DENY SELECT ON			schema::saucer
TO						[---comp---\---user---]

REVERT


CREATE LOGIN			[---comp---\---another user---]
FROM					windows

CREATE USER				[---comp---\---another user---]


CREATE ROLE				saucer_reader
GRANT					SELECT
ON						schema::saucer
TO						saucer_reader


SELECT					pri.name	AS [role],
						pri2.name	AS [principal]				
FROM					sys.database_role_members	AS rm
JOIN					sys.database_principals		AS pri		
ON						pri.principal_id = rm.role_principal_id
JOIN					sys.database_principals		AS pri2
ON						pri2.principal_id = rm.member_principal_id
WHERE					pri2.name = '---comp---\---another user---'

SELECT					*
FROM					sys.database_role_members

SELECT					pri.name	AS [role],
						pri2.name	AS [principal]				
FROM					sys.database_role_members	AS rm
JOIN					sys.database_principals		AS pri		
ON						pri.principal_id = rm.role_principal_id
JOIN					sys.database_principals		AS pri2
ON						pri2.principal_id = rm.member_principal_id
WHERE					pri2.name = '---comp---\---user---'

EXECUTE AS				user = '---comp---\---another user---'

SELECT					*
FROM					saucer.planets -- should not work as another user does not have permissisons

REVERT

sp_addrolemember		'saucer_reader', '---comp---\---another user---'

SELECT					*
FROM					saucer.planets

REVERT



SELECT					pri.name	AS [role],
						pri2.name	AS [principal]				
FROM					sys.database_role_members	AS rm
JOIN					sys.database_principals		AS pri		
ON						pri.principal_id = rm.role_principal_id
JOIN					sys.database_principals		AS pri2
ON						pri2.principal_id = rm.member_principal_id
WHERE					pri2.name = '---comp---\---another user---'



CREATE ROLE				no_saucer

DENY					CONTROL
ON						schema::saucer
TO						no_saucer

sp_addrolemember 'no_saucer', '---comp---\---another user---'

SELECT					pri.name	AS [role],
						pri2.name	AS [principal]				
FROM					sys.database_role_members	AS rm
JOIN					sys.database_principals		AS pri		
ON						pri.principal_id = rm.role_principal_id
JOIN					sys.database_principals		AS pri2
ON						pri2.principal_id = rm.member_principal_id
WHERE					pri2.name = '---comp---\---another user---'

EXECUTE AS				user = '---comp---\---another user---'

SELECT					*
FROM					saucer.planets


REVERT