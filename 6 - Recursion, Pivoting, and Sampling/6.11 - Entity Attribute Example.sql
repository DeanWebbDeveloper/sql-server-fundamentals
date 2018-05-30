USE				[Recursion etc]

-- table to hold product entities

CREATE TABLE	[products]
(
	id		INT PRIMARY KEY,
	name	VARCHAR(MAX)
)

-- table to hold product attributes

CREATE TABLE	[properties]
(
	id		INT,
	name	VARCHAR(50),
	value	VARCHAR(max),
	-- restrict as one to many relationship
	CONSTRAINT PK_properties PRIMARY KEY (id, name),
	-- one table is products
	FOREIGN KEY (id) REFERENCES products (id)
)

SELECT TOP(10)	*
FROM			[products]			-- empty
SELECT TOP(10)	*
FROM			[properties]		-- empty

SELECT DISTINCT	[name]
FROM			[properties]

SELECT			*
FROM			[properties]
PIVOT
(
	MAX			([value])
	-- rows that have a name equal to
	FOR			[name]
	IN			([len], [fiber], [pitch], [amount], [width], [type], [color])
)
AS				p


-- Swish table

SELECT			*
FROM			[properties]
PIVOT
(
	-- each value will come from the corresponding 'value'
	-- column of the properties table
	MAX			([value])
	-- rows that have a name equal to
	-- 'color', 'type' or 'amount' will
	-- be added to the columns of the output table
	FOR			[name]
	IN			([color], [type], [amount])
)
AS				p
-- this limits the virtual table to Swish rows
WHERE			[id]
IN
(
	SELECT		[id]
	FROM		[products]
	WHERE		[name]= 'Swish'
)



-- Rugs table

SELECT			*
FROM			[properties]
PIVOT
(
	-- each value will come from the corresponding 'value'
	-- column of the properties table
	MAX			([value])
	-- rows that have a name equal to
	-- 'color', 'len', 'width' or 'fiber' will
	-- be added to the columns of the output table
	FOR			[name]
	IN			([color], [len], [width], [fiber])
)
AS				p
-- this limits the virtual table to rug rows
WHERE			[id]
IN
(
	SELECT		[id]
	FROM		[products]
	WHERE		[name]= 'rug'
)