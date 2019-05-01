--REVOKE SELECT ON bloomapp.UniqueUserVersion FROM bloomappuser;
--DROP VIEW bloomapp.UniqueUserVersion;

CREATE VIEW bloomapp.UniqueUserVersion AS
	select DISTINCT ON (a.user_id) USER_ID,
			a.version, CAST ('03 mo' as Text) AS Reference
	from bloomapp.create_book AS a
		where
     a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '3 months')
	 	 and
	 a.timestamp < date_trunc('month', CURRENT_DATE);  
	
GRANT SELECT ON bloomapp.UniqueUserVersion TO bloomappuser;
select * FROM bloomapp.UniqueUserVersion;

select * from bloomapp.create_book order by user_id ASC LIMIT 100;

GRANT ALL PRIVILEGES on bloomapp.UniqueUserVersion to bloomappuser,readbloom, silpgadmin, segment;