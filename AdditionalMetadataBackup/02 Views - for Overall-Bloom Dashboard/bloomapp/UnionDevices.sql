REVOKE SELECT ON bloomreadertest.UnionDevices FROM readbloomtester;
DROP VIEW bloomreadertest.UnionDevices CASCADE;

CREATE VIEW bloomreadertest.UnionDevices AS
	SELECT * FROM bloomreader.allDevices 
	UNION ALL
	SELECT * FROM bloomreaderbeta.allDevices; 

GRANT SELECT ON bloomreadertest.UnionDevices TO readbloomtester;
select * FROM bloomreadertest.UnionDevices ;

