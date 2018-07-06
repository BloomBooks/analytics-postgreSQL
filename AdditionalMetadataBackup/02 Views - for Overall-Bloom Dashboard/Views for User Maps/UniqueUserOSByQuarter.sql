--REVOKE SELECT ON bloomreadertest.UniqueUserOSByQuarter FROM readbloomtester;
--DROP VIEW bloomreadertest.UniqueUserOSByQuarter;

CREATE VIEW bloomreadertest.UniqueUserOSByQuarter AS
	select DISTINCT ON (a.user_id) USER_ID,
			a.browser, CAST ('4th Quarter' as Text) AS Reference
	from bloomapp.create_book AS a
		where
     a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '3 months')
	 and
	 a.timestamp < date_trunc('month', CURRENT_DATE)
	UNION ALL
	select DISTINCT ON (b.user_id) USER_ID,
			b.browser, CAST ('3rd Quarter' as Text) AS Reference
	from bloomapp.create_book AS b
		where
     b.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '6 months')	
	 and 
	 b.timestamp < date_trunc('month', CURRENT_DATE) - INTERVAL '3 months'
	UNION ALL
	select DISTINCT ON (c.user_id) USER_ID,
			c.browser, CAST ('2nd Quarter' as Text) AS Reference
	from bloomapp.create_book AS c
		where
     c.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '9 months')	
	 and 
	 c.timestamp < date_trunc('month', CURRENT_DATE) - INTERVAL '6 months'
	UNION ALL
	select DISTINCT ON (d.user_id) USER_ID,
			d.browser, CAST ('1st Quarter' as Text) AS Reference
	from bloomapp.create_book AS d
		where
     d.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '12 months')	
	 and 
	 d.timestamp < date_trunc('month', CURRENT_DATE) - INTERVAL '9 months'
	;  
	
GRANT SELECT ON bloomreadertest.UniqueUserOSByQuarter TO readbloomtester;
select * FROM bloomreadertest.UniqueUserOSByQuarter ;