SELECT			name
FROM			[personnel (small)]
WHERE			node.IsDescendantOf('/2/')
=				1
;

-- just descendants
SELECT			name
FROM			[personnel (small)]
WHERE			node.IsDescendantOf('/2/')
=				1
AND				node
!=				'/2/';

-- direct descendants

SELECT			name
FROM			[personnel (small)]
WHERE			node.IsDescendantOf('/2/')
=				1
AND				node.GetLevel()
=				2

DECLARE			@boss hierarchyid;
SET				@boss
=				'/3/1/'
SELECT			name
FROM			[personnel (small)]
WHERE			node.IsDescendantOf(@boss)
=				1
AND				node.GetLevel() = @boss.GetLevel()
+				1

-- power metric

SELECT			P1.name,(
SELECT
COUNT			(*) - 1
FROM			[personnel (small)]
WHERE			node.IsDescendantOf(P1.node)
=				1)
AS				power
FROM			[personnel (small)]
AS				P1