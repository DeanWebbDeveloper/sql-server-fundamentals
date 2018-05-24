-- add between

DECLARE			@leftNode hierarchyid
DECLARE			@rightNode hierarchyid
SET				@leftNode
=				'/2/2/';
SET				@rightNode
=				'/2/3/';

WITH			[between] (node)
AS
(
SELECT			@leftNode.GetAncestor(1).GetDescendant(@leftNode, @rightNode)
)
--SELECT		node.ToString() FROM [between]

INSERT
INTO			[personnel (small)]
(				[name]
,				[hourly rate]
,				[node]
)
VALUES
(				'Between3'
,				100
,
	(
	SELECT		node
	FROM		[between]
	)
)

SELECT			node.ToString()
,				*
FROM			[personnel (small)]