USE	AdventureWorks;

SELECT	emp.EmployeeID, per.FirstName, per.LastName
FROM	[HumanResources].[Employee]
AS		emp
INNER
JOIN	[Person].[Contact]
AS		per
ON		emp.ContactID
=		per.ContactID;

USE People;

CREATE
TABLE	stuff
(		id INT IDENTITY
,		name VARCHAR(50)
);

INSERT
INTO	stuff
VALUES	('asdfasdf');

INSERT
INTO	stuff
VALUES	('asdfasdfasdfasdf');

INSERT
INTO	stuff
VALUES	('asdfasdfasdfasdfasdfasdf');

SELECT * FROM STUFF