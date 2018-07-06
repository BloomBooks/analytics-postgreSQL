REVOKE SELECT ON bloomreadertest.TimePerMon FROM readbloomtester;
DROP VIEW bloomreadertest.TimePerMon CASCADE;

CREATE VIEW bloomreadertest.TimePerMon AS
	SELECT COUNT(*) AS num_opened,
          CAST (date_part('YEAR',
                    a.timestamp AT TIME ZONE 'AEST'       
                     ) as text)||
		  CAST (LPAD((date_part('MONTH',a.timestamp AT TIME ZONE 'AEST'))::text, 2, '0')  as text)		
					AS Month_Used,
          a.timestamp::timestamp::date,
		(SELECT d.country_name from public.ip2loc_sm_tab AS d
		   WHERE public.ip2int(a.context_ip) = d.context_ip) AS Country
	FROM (SELECT * FROM bloomreader.application_opened 
		  UNION ALL
		  SELECT * FROM bloomreaderbeta.application_opened )AS a
 	WHERE a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '12 months') 
	  --AND a.timestamp < date_trunc('month', CURRENT_DATE)
    GROUP BY a.timestamp, a.timestamp::timestamp::date, a.context_ip;

GRANT SELECT ON bloomreadertest.TimePerMon TO readbloomtester;
select * FROM bloomreadertest.TimePerMon as a
 Where a.timestamp > '2017-06-30'
  ORDER BY a.timestamp;

