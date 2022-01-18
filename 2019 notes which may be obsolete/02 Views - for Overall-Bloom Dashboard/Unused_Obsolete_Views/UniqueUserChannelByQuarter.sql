--REVOKE SELECT ON bloomreadertest.UniqueUserChannel FROM readbloomtester;
--DROP VIEW bloomreadertest.UniqueUserChannel ;

CREATE VIEW bloomreadertest.UniqueUserChannel AS
	select DISTINCT ON (a.user_id) USER_ID,
			a.channel, CAST ('03 mo' as Text) AS Reference
	from bloomapp.create_book AS a
		where
     a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '3 months')
	 	 and
	 a.timestamp < date_trunc('month', CURRENT_DATE);
	 /*
	UNION ALL
	select DISTINCT ON (b.user_id) USER_ID,
			b.channel, CAST ('06 mo' as Text) AS Reference
	from bloomapp.create_book AS b
		where
     b.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '6 months')	
	UNION ALL
	select DISTINCT ON (c.user_id) USER_ID,
			c.channel, CAST ('09 mo' as Text) AS Reference
	from bloomapp.create_book AS c
		where
     c.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '9 months')	
	UNION ALL
	select DISTINCT ON (d.user_id) USER_ID,
			d.channel, CAST ('12 mo' as Text) AS Reference
	from bloomapp.create_book AS d
		where
     d.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '12 months')	
	;  */
	
GRANT SELECT ON bloomreadertest.UniqueUserChannel TO readbloomtester;
select * FROM bloomreadertest.UniqueUserChannel ;

select * from bloomapp.create_book order by user_id ASC LIMIT 100;

GRANT ALL PRIVILEGES on bloomreadertest.UniqueUserChannel to bloomappuser,readbloom, silpgadmin, segment;