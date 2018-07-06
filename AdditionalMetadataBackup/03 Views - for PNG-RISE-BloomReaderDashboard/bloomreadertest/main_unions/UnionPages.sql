REVOKE SELECT ON bloomreadertest.UnionPages FROM readbloomtester;
DROP VIEW bloomreadertest.UnionPages CASCADE;

CREATE VIEW bloomreadertest.UnionPages AS
	SELECT * FROM bloomreader.pages_read
	UNION ALL
	SELECT * FROM bloomreaderbeta.pages_read;
--	UNION ALL
--	SELECT * FROM bloomreadertest.pages_read;   

GRANT SELECT ON bloomreadertest.UnionPages TO readbloomtester;
select * FROM bloomreadertest.UnionPages ;