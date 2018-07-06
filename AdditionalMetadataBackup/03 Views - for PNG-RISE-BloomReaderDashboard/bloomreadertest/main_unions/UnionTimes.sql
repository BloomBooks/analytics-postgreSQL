REVOKE SELECT ON bloomreadertest.UnionTimes FROM readbloomtester;
DROP VIEW bloomreadertest.UnionTimes CASCADE;

CREATE VIEW bloomreadertest.UnionTimes AS
	SELECT * FROM bloomreader.application_opened 
	UNION ALL
	SELECT * FROM bloomreaderbeta.application_opened; 
   

GRANT SELECT ON bloomreadertest.UnionTimes TO readbloomtester;
select * FROM bloomreadertest.UnionTimes   ;