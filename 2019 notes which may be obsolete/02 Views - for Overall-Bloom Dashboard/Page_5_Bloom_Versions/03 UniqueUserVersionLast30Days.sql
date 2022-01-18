--REVOKE SELECT ON bloomapp.UniqueUserVersionLast30Days FROM bloomappuser;
--DROP VIEW bloomapp.UniqueUserVersionLast30Days;

CREATE VIEW bloomapp.UniqueUserVersionLast30Days AS
	select DISTINCT ON (a.user_id) USER_ID,
			a.version, a.timestamp
	from bloomapp.create_book AS a
	where a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '1 months');
	
GRANT SELECT ON bloomapp.UniqueUserVersionLast30Days TO bloomappuser;
select * FROM bloomapp.UniqueUserVersionLast30Days;