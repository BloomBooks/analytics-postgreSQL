REVOKE SELECT ON bloomreadertest.UniqueUserOS FROM readbloomtester;
DROP VIEW bloomreadertest.UniqueUserOS;

CREATE VIEW bloomreadertest.UniqueUserOS AS
	select DISTINCT ON (a.user_id) USER_ID,
			a.browser
	from bloomapp.create_book AS a;
/*		where    ---WAS LAST THREE MONTHS
     a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '3 months')
	 	 and
	 a.timestamp < date_trunc('month', CURRENT_DATE);  
*/	
GRANT SELECT ON bloomreadertest.UniqueUserOS TO readbloomtester;
select * FROM bloomreadertest.UniqueUserOS;
