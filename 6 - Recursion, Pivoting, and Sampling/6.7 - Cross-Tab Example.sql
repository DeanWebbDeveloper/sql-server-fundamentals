USE			[Recursion etc]

sp_help		[sales receipts]

SELECT		TOP 10 *
FROM		[sales receipts];

SELECT		COUNT(*)
FROM		[sales receipts];

SELECT		*
FROM		[sales receipts]
PIVOT
(
	COUNT	(id)
	FOR		[payment] IN ([VISA], [AmEx], [MasterCard], Cash)
)
AS			p
ORDER BY	[date]


SELECT		*
FROM
(
	SELECT	id, CAST([date] AS date) AS [date],
			payment
	FROM	[sales receipts]
)
AS			t
PIVOT
(
			COUNT(id)
	FOR		[payment]
	IN		([VISA], [AmEx], [MasterCard], Cash)
)
AS			p
ORDER BY	[date]


SELECT		*
FROM
(
	SELECT	total, CAST([date] AS date) AS [date],
			payment
	FROM	[sales receipts]
)
AS			t
PIVOT
(
			SUM(total)
	FOR		[payment]
	IN		([VISA], [AmEx], [MasterCard], Cash)
)
AS			p
ORDER BY	[date]


SELECT		CAST([date] AS date) as [date],
COUNT		(CASE WHEN payment = 'VISA' THEN 1 END) as VISA,
COUNT		(CASE WHEN payment = 'AmEx' THEN 1 END) as AmEx,
COUNT		(CASE WHEN payment = 'MasterCard' THEN 1 END) as MasterCard,
COUNT		(CASE WHEN payment = 'Cash' THEN 1 END) as Cash
FROM		[sales receipts]
GROUP BY	CAST([date] AS date)
ORDER BY	date