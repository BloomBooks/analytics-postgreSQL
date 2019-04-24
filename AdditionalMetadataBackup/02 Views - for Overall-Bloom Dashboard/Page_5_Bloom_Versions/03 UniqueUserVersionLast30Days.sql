--REVOKE SELECT ON bloomreadertest.UniqueUserVersionLast30Days FROM readbloomtester;
--DROP VIEW bloomreadertest.UniqueUserVersionLast30Days;

CREATE VIEW bloomreadertest.UniqueUserVersionLast30Days AS
	select DISTINCT ON (a.user_id) USER_ID,
			a.version, a.timestamp
	from bloomapp.create_book AS a
	where a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '1 months');
	
GRANT SELECT ON bloomreadertest.UniqueUserVersionLast30Days TO readbloomtester;
select * FROM bloomreadertest.UniqueUserVersionLast30Days;