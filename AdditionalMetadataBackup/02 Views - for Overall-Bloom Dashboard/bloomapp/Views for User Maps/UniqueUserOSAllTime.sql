--REVOKE SELECT ON bloomreadertest.UniqueUserOSAllTime FROM readbloomtester;
--DROP VIEW bloomreadertest.UniqueUserOSAllTime;

CREATE VIEW bloomreadertest.UniqueUserOSAllTime AS
	select DISTINCT ON (a.user_id) USER_ID,	
	a.browser as OperSys
	from bloomapp.create_book AS a; 
	
GRANT SELECT ON bloomreadertest.UniqueUserOSAllTime TO readbloomtester;
select * FROM bloomreadertest.UniqueUserOSAllTime;