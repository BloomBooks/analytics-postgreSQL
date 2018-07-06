REVOKE SELECT ON bloomreadertest.UnionPhones FROM readbloomtester;
DROP VIEW bloomreadertest.UnionPhones CASCADE;

CREATE VIEW bloomreadertest.UnionPhones AS
	SELECT * FROM bloomreader.phonesPNG 
	UNION ALL
	SELECT * FROM bloomreaderbeta.phonesPNG;
    

GRANT SELECT ON bloomreadertest.UnionPhones TO readbloomtester;
select * FROM bloomreadertest.UnionPhones ;

