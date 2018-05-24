-- add new employee

DECLARE			@boss hierarchyid;
SET				@boss
=				'/2/' --Mary
;

WITH			[next direct report] (node)
AS
(
	SELECT		@boss.GetDescendant
	(			null	
	,			MIN(node)
	)
	FROM		[personnel (small)]
	WHERE		node.IsDescendantOf(@boss)
	=			1
	AND			node.GetLevel()
	=			@boss.GetLevel() + 1
)

--SELECT			node.ToString()
--FROM			[next direct report]

INSERT
INTO			[personnel (small)]
				(name, [hourly rate], node)
VALUES
(				'Julian'
,				100
,
	(
	SELECT		node
	FROM		[next direct report]
	)
)

SELECT			node.ToString()
,				*
FROM			[personnel (small)]