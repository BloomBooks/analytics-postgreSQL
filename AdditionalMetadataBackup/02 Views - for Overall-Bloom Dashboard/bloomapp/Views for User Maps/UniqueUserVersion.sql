--REVOKE SELECT ON bloomreadertest.UniqueUserVersion FROM readbloomtester;
--DROP VIEW bloomreadertest.UniqueUserVersion;

CREATE VIEW bloomreadertest.UniqueUserVersion AS
	select DISTINCT ON (a.user_id) USER_ID,
			a.version, CAST ('03 mo' as Text) AS Reference
	from bloomapp.create_book AS a
		where
     a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '3 months')
	 	 and
	 a.timestamp < date_trunc('month', CURRENT_DATE);  
	
GRANT SELECT ON bloomreadertest.UniqueUserVersion TO readbloomtester;
select * FROM bloomreadertest.UniqueUserVersion;

select * from bloomapp.create_book order by user_id ASC LIMIT 100;

GRANT ALL PRIVILEGES on bloomreadertest.LaunchLocs to bloomappuser,readbloom, silpgadmin, segment;