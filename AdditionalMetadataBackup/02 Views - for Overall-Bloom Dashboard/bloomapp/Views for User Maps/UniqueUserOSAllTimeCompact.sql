--REVOKE SELECT ON bloomreadertest.UniqueUserOSAllTimeCompact FROM readbloomtester;
--DROP VIEW bloomreadertest.UniqueUserOSAllTimeCompact;

CREATE VIEW bloomreadertest.UniqueUserOSAllTimeCompact AS
	select DISTINCT ON (a.user_id) USER_ID,	
	CASE
		WHEN position('UBUNTU' in upper(a.browser)) > 0 THEN 'Linux' 
		WHEN position('LINUX' in upper(a.browser)) > 0 THEN 'Linux' 
		ELSE a.browser END as OperSys
	FROM bloomapp.create_book AS a; 
	
GRANT SELECT ON bloomreadertest.UniqueUserOSAllTimeCompact TO readbloomtester;
select * FROM bloomreadertest.UniqueUserOSAllTimeCompact;