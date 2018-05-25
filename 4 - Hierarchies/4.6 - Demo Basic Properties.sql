CREATE DATABASE Hierarchy;

USE Hierarchy;

-- hierarchyid as a number path
DECLARE @hid HIERARCHYID;
SET @hid = '/1/2/3/4/';
SELECT @hid, @hid.ToString();

-- syntax depends on final /
DECLARE @hid HIERARCHYID;
SET @hid = '/1/2/3/4';

-- sorting hierarchyid's
-- msd radix sort
DECLARE @hid1 HIERARCHYID;
DECLARE @hid2 HIERARCHYID;
SET @hid1 = '/1/2/3/1/';
SET @hid2 = '/1/2/2/4/';
SELECT hid.ToString() FROM
	(SELECT @hid1 AS hid
	UNION
	SELECT @hid2 AS hid) AS a
	ORDER BY hid;
	
-- adding length produces breadth first sort
DECLARE @hid1 HIERARCHYID;
DECLARE @hid2 HIERARCHYID;
SET @hid1 = '/1/2/2/1/';
SET @hid2 = '/1/1/2/1/2/';
SELECT hid.ToString() FROM
	(SELECT 4 AS len, @hid1 as hid
	UNION SELECT 5 as len, @hid2 as hid) AS a
	ORDER BY len, hid;