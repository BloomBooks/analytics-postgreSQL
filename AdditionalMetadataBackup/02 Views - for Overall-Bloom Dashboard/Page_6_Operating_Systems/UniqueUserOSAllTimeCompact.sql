--REVOKE SELECT ON bloomapp.UniqueUserOSAllTimeCompact FROM bloomappuser;
--DROP VIEW bloomapp.UniqueUserOSAllTimeCompact;

CREATE VIEW bloomapp.UniqueUserOSAllTimeCompact AS
	select DISTINCT ON (a.user_id) USER_ID,	
	CASE
		WHEN position('UBUNTU' in upper(a.browser)) > 0 THEN 'Linux' 
		WHEN position('LINUX' in upper(a.browser)) > 0 THEN 'Linux' 
		ELSE a.browser END as OperSys
	FROM bloomapp.create_book AS a; 
	
GRANT SELECT ON bloomapp.UniqueUserOSAllTimeCompact TO bloomappuser;
select * FROM bloomapp.UniqueUserOSAllTimeCompact;