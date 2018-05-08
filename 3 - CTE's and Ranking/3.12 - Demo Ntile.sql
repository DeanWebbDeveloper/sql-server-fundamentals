USE CTERankingPartitioning;

SELECT * FROM [employees];

-- break into percentiles
SELECT		[first name],
			[last name],
			[base rate],
NTILE		(100)
OVER		(
ORDER BY	[base rate]
			)
AS			percentile
FROM		[employees]
ORDER BY	percentile
DESC
;


-- numebr of tiles is expression
-- get approx 200 employees per tile
SELECT		[first name],
			[last name],
			[base rate],
NTILE		((
			SELECT COUNT(*) / 200 FROM [employees]
			))
OVER		(
ORDER BY	[base rate]
			)
AS			[base tile]
FROM		employees
ORDER BY	[base tile]
;

