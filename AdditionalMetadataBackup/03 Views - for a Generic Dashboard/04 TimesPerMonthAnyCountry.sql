REVOKE SELECT ON bloomreader.TimePerMon_anycountry FROM readbloomtester;
DROP VIEW bloomreader.TimePerMon_anycountry CASCADE;

CREATE OR REPLACE VIEW bloomreader.TimePerMon_anycountry AS
	SELECT a.id,
          CAST((a.timestamp AT TIME ZONE 'AEST') AS date) AS timedate,
		   b.country_name AS country
	FROM (SELECT * FROM bloomreader.application_opened 
		  UNION ALL
		  SELECT * FROM bloomreaderbeta.application_opened ) AS a
	INNER JOIN (SELECT DISTINCT d.loc_uid, d.country_name
            FROM countryregioncitylu AS d) AS b ON 
            a.location_uid = b.loc_uid
--	WHERE CAST((a.timestamp AT TIME ZONE 'AEST') AS date) > ((date_trunc('month', (CAST((current_date AT TIME ZONE 'AEST') AS date))) - interval '1 day') - INTERVAL '12 months')		
 	WHERE CAST((a.timestamp AT TIME ZONE 'AEST') AS date) > ((date_trunc('month', (CAST((current_date AT TIME ZONE 'AEST') AS date)))) - INTERVAL '11 months') 
--	  AND CAST((a.timestamp AT TIME ZONE 'AEST') AS date) < date_trunc('month', (CAST((current_date AT TIME ZONE 'AEST') AS date)))
    GROUP BY CAST((a.timestamp AT TIME ZONE 'AEST') AS date), a.id, b.country_name;

GRANT SELECT ON bloomreader.TimePerMon_anycountry TO bloomreaderuser;
GRANT SELECT ON bloomreader.TimePerMon_anycountry TO readbloomtester;
GRANT SELECT ON bloomreader.TimePerMon_anycountry TO bloomgtuser;
select * FROM bloomreader.TimePerMon_anycountry AS a where a.country = 'Guatemala';