SELECT			*
FROM			sys.dm_exec_cached_plans;

SELECT			*
FROM			sys.dm_exec_query_plan(0x0600080028382622B8019C80000000000000000000000000);

SELECT			*
FROM			sys.dm_exec_sql_text(0x0600080028382622B8019C80000000000000000000000000);

CREATE FUNCTION	SqlAndPlan (@handle VARBINARY(MAX))
RETURNS			TABLE
AS
RETURN	SELECT	sql.text,
				cp.usecounts,
				cp.cacheobjtype,
				cp.objtype,
				cp.size_in_bytes,
				qp.query_plan
		FROM	sys.dm_exec_sql_text(@handle)
AS				SQL
CROSS
JOIN			sys.dm_exec_query_plan(@handle)
AS				qp
JOIN			sys.dm_exec_cached_plans
AS				cp
ON				cp.plan_handle = @handle;

SELECT			*
FROM			SqlAndPlan(0x0600080028382622B8019C80000000000000000000000000);

CREATE VIEW		PlanCache
AS
SELECT			sp.*
FROM			sys.dm_exec_cached_plans
AS				cp
CROSS
APPLY			SqlAndPlan(cp.plan_handle)
AS				sp;

SELECT			*
FROM			PlanCache;

dbcc			freeproccache