USE			Hierarchy;

SELECT		node.ToString(),
			*
FROM		[personnel (small)]

DECLARE		@oldRoot HIERARCHYID
DECLARE		@newRoot HIERARCHYID

SET			@oldRoot = '/2/'	--Mary
SET			@newRoot = '1/3/'	--Now works for Joe

SELECT		node.GetReparentedValue(@oldRoot, @newRoot).ToString(),
			node.ToString(),
			*
FROM		[personnel (small)]
WHERE		node.IsDescendantOf(@oldRoot) = 1;

UPDATE		[personnel(small)]
SET			node = node.GetReparentedValue(@oldRoot, @newRoot)
WHERE		node.IsDescendantOf(@oldRoot) = 1;