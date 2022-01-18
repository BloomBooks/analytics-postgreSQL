--REVOKE SELECT ON bloomapp.UniqueUserOS FROM bloomappuser;
--DROP VIEW bloomapp.UniqueUserOS;

CREATE VIEW bloomapp.UniqueUserOS AS
	select DISTINCT ON (a.user_id) USER_ID,
			a.browser
	from bloomapp.create_book AS a;
	
GRANT SELECT ON bloomapp.UniqueUserOS TO bloomappuser;
select * FROM bloomapp.UniqueUserOS;
