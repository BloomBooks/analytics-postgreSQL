REVOKE SELECT ON bloomreader.TimePerMonGT FROM readbloomtester;
DROP VIEW bloomreader.TimePerMonGT CASCADE;

CREATE OR REPLACE VIEW bloomreader.TimePerMonGT AS
	SELECT a.id,
          CAST((a.timestamp AT TIME ZONE 'AEST') AS date) AS timedate
	FROM (SELECT * FROM bloomreader.application_opened
		  UNION ALL
		  SELECT * FROM bloomreaderbeta.application_opened) AS a
		  	 INNER JOIN bloomreader.pages_read AS f ON	   	 
		   		a.context_device_id = f.context_device_id and	         
				f.branding_project_name = 'Juarez-Guatemala'
	INNER JOIN public.ip2loc_sm_tab AS b ON	   	 
		 b.country_name = 'Guatemala' and	         
			public.ip2int(a.context_ip) = b.context_ip			
	WHERE CAST((a.timestamp AT TIME ZONE 'AEST') AS date) > ((date_trunc('month', (CAST((current_date AT TIME ZONE 'AEST') AS date)))) - INTERVAL '11 months') 
    GROUP BY CAST((a.timestamp AT TIME ZONE 'AEST') AS date), a.id, a.context_ip;

GRANT SELECT ON bloomreader.TimePerMonGT TO readbloomtester;
GRANT SELECT ON bloomreader.TimePerMonGT TO bloomgtuser;
select * FROM bloomreader.TimePerMonGT;