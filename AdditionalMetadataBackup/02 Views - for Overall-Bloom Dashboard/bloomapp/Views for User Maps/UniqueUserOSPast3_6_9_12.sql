--REVOKE SELECT ON bloomreadertest.UniqueUserOSPast3_6_9_12 FROM readbloomtester;
--DROP VIEW bloomreadertest.UniqueUserOSPast3_6_9_12;

CREATE VIEW bloomreadertest.UniqueUserOSPast3_6_9_12 AS
	select DISTINCT ON (a.user_id) USER_ID,
			a.browser, CAST ('03 mo' as Text) AS Reference
	from bloomapp.create_book AS a
		where
     a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '3 months')
	 	 and
	 a.timestamp < date_trunc('month', CURRENT_DATE)
	UNION ALL
	select DISTINCT ON (b.user_id) USER_ID,
			b.browser, CAST ('06 mo' as Text) AS Reference
	from bloomapp.create_book AS b
		where
     b.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '6 months')	
	UNION ALL
	select DISTINCT ON (c.user_id) USER_ID,
			c.browser, CAST ('09 mo' as Text) AS Reference
	from bloomapp.create_book AS c
		where
     c.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '9 months')	
	UNION ALL
	select DISTINCT ON (d.user_id) USER_ID,
			d.browser, CAST ('12 mo' as Text) AS Reference
	from bloomapp.create_book AS d
		where
     d.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '12 months')	
	;  
	
GRANT SELECT ON bloomreadertest.UniqueUserOSPast3_6_9_12 TO readbloomtester;
select * FROM bloomreadertest.UniqueUserOSPast3_6_9_12 ;