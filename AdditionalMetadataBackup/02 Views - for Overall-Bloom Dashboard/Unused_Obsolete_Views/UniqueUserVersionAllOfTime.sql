--REVOKE SELECT ON bloomreadertest.UniqueUserVersionAllOfTime FROM readbloomtester;
--DROP VIEW bloomreadertest.UniqueUserVersionAllOfTime;

CREATE VIEW bloomreadertest.UniqueUserVersionAllOfTime AS
	SELECT DISTINCT ON (a.user_id) USER_ID, a.version, a.timestamp
	FROM bloomapp.create_book AS a
	WHERE a.timestamp < date_trunc('month', current_date);
	--AND a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '12 months');
	
GRANT SELECT ON bloomreadertest.UniqueUserVersionAllOfTime TO readbloomtester;
select * FROM bloomreadertest.UniqueUserVersionAllOfTime;
