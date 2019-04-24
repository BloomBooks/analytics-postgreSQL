REVOKE SELECT ON bloomreader.TimePerMonPNG FROM bloomreaderuser;
DROP VIEW bloomreader.TimePerMonPNG CASCADE;

CREATE VIEW bloomreader.TimePerMonPNG AS
	SELECT a.id,
          CAST((a.timestamp AT TIME ZONE 'AEST') AS date) AS timedate
	FROM (SELECT * FROM bloomreader.application_opened 
		  UNION ALL
		  SELECT * FROM bloomreaderbeta.application_opened )AS a
	INNER JOIN public.ip2loc_sm_tab AS b ON	   	 
		 b.country_name = 'Papua New Guinea' and	         
			public.ip2int(a.context_ip) = b.context_ip	
 	WHERE CAST((a.timestamp AT TIME ZONE 'AEST') AS date) > ((date_trunc('month', (CAST((current_date AT TIME ZONE 'AEST') AS date))) - interval '1 day') - INTERVAL '12 months') 
	  AND CAST((a.timestamp AT TIME ZONE 'AEST') AS date) < date_trunc('month', (CAST((current_date AT TIME ZONE 'AEST') AS date)))
    GROUP BY CAST((a.timestamp AT TIME ZONE 'AEST') AS date), a.id, a.context_ip;

GRANT SELECT ON bloomreader.TimePerMonPNG TO bloomreaderuser;
select * FROM bloomreader.TimePerMonPNG;