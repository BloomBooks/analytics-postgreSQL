REVOKE SELECT ON bloomreader.TimePerMonGT FROM readbloomtester;
DROP VIEW bloomreader.TimePerMonGT CASCADE;

CREATE OR REPLACE VIEW bloomreader.TimePerMonGT AS
	SELECT a.id,
          CAST((a.timestamp AT TIME ZONE 'AEST') AS date) AS timedate
	FROM (SELECT * FROM bloomreader.application_opened
		  UNION ALL
		  SELECT * FROM bloomreaderbeta.application_opened) AS a
		  	 INNER JOIN (SELECT x.context_device_id FROM bloomreader.pages_read AS x
						 WHERE x.branding_project_name = 'Juarez-Guatemala'
						UNION DISTINCT 
						SELECT y.context_device_id FROM bloomreaderbeta.pages_read AS y
						WHERE y.branding_project_name = 'Juarez-Guatemala')  AS f ON	   	 
		   		a.context_device_id = f.context_device_id 	         
	WHERE CAST((a.timestamp AT TIME ZONE 'AEST') AS date) > ((date_trunc('month', (CAST((current_date AT TIME ZONE 'AEST') AS date)))) - INTERVAL '11 months')
	 AND CAST((a.timestamp AT TIME ZONE 'AEST') AS date) > '2019-02-26'
	GROUP BY CAST((a.timestamp AT TIME ZONE 'AEST') AS date), a.id ;

GRANT SELECT ON bloomreader.TimePerMonGT TO readbloomtester;
GRANT SELECT ON bloomreader.TimePerMonGT TO bloomgtuser;
select * FROM bloomreader.TimePerMonGT;
