-- authorisation, principals, objects and permissions

SELECT				*
FROM				sys.server_principals

ALTER LOGIN			[---comp---\---user---] DISABLE

ALTER LOGIN			[---comp---\---user---] ENABLE