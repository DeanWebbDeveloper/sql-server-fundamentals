USE Hierarchy;

--depth-first

CREATE
UNIQUE
INDEX			idx_depth
ON				[personnel (small)] (node);

--breadth-first

CREATE
INDEX			idx_breadth
ON				[personnel (small)]	(node.GetLevel(),
									node);

ALTER TABLE		[personnel (small)]
ADD				NodeLevel
AS				node.GetLevel();

CREATE INDEX	idx_breadth
ON				[personnel (small)](NodeLevel, node);

CREATE TRIGGER	dbo.BossDelete
ON				[personnel (small)]
FOR DELETE
AS
IF EXISTS
	(SELECT		*
	FROM		[personnel (small)]
	AS			P
	JOIN		deleted
	ON P.[node].IsDescendantOf(deleted.node) = 1
	AND P.node != deleted.node
	)
BEGIN
	RAISERROR('has descendants', 10, 1);
	ROLLBACK TRANSACTION;
END

--DELETE [personnel (small)] WHERE node ='/1/';

--DELETE [personnel (small)] WHERE node ='/1/3/1/1/';

CREATE
TRIGGER			dbo.PersonnelChange
ON				[personnel (small)]
FOR				INSERT,
				UPDATE
AS
--trigger fires if any inserted node lacks a parent
--unless the node is '/'
IF EXISTS
	(SELECT		node.ToString()
	FROM		inserted
	WHERE NOT EXISTS
		(SELECT	node
		FROM	[personnel (small)]
		WHERE	node = inserted.node.GetAncestor(1)
		)
	AND node != HIERARCHYID::GetRoot()
	)
BEGIN
	RAISERROR('missing parent', 10, 1);
	ROLLBACK TRANSACTION;
END;

--INSERT INTO [personnel (small)] VALUES ('Markus', 10, '/1/2/3/4/5/6/');
--INSERT INTO [personnel (small)] VALUES ('Markus', 10, '/1/3/10/');