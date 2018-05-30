USE				[Recursion etc]

SELECT			*
INTO			[#pivoted receipts]
FROM
(
	SELECT		id, CAST([date] as date)
	AS			[date], [payment]
	FROM		[sales receipts]
)
AS				t
PIVOT
(
	COUNT		(id)
	FOR			[payment]
	IN			([VISA], [AmEx], [MasterCard], [Cash])
)
AS				p

SELECT			*
FROM			[#pivoted receipts];

SELECT			*
FROM			[#pivoted receipts]
UNPIVOT
(
				[sales]
	FOR			[payment]
	IN			([VISA], [AmEx], [MasterCard], [Cash])
)
AS				p
ORDER BY		date, [payment]


SELECT			CAST([date] AS date) AS [date],
				COUNT(*) AS [sale],
				[payment] FROM [sales receipts]
GROUP BY		[payment], CAST([date] AS date)
ORDER BY		date, [payment]