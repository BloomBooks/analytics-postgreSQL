REVOKE SELECT ON bloomreadertest.TimePerMonPNG FROM readbloomtester;
DROP VIEW bloomreadertest.TimePerMonPNG CASCADE;

CREATE VIEW bloomreadertest.TimePerMonPNG AS
	SELECT COUNT(*) AS num_opened,
          CAST (date_part('YEAR',
                    a.timestamp AT TIME ZONE 'AEST'       
                     ) as text)||
		  CAST (LPAD((date_part('MONTH',a.timestamp AT TIME ZONE 'AEST'))::text, 2, '0')  as text)		
					AS Month_Used,
          a.timestamp::timestamp::date
	FROM (SELECT * FROM bloomreader.application_opened 
		  UNION ALL
		  SELECT * FROM bloomreaderbeta.application_opened )AS a
	INNER JOIN public.ip2loc_sm_tab AS b ON	   	 
		 b.country_name = 'Papua New Guinea' and	         
			public.ip2int(a.context_ip) = b.context_ip	
	 WHERE a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '12 months') 
	  --AND a.timestamp < date_trunc('month', CURRENT_DATE)
	  GROUP BY a.timestamp, a.timestamp::timestamp::date, a.context_ip;

GRANT SELECT ON bloomreadertest.TimePerMonPNG TO readbloomtester;
select * FROM bloomreadertest.TimePerMonPNG;

