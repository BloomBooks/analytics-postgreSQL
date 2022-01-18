REVOKE SELECT ON bloomreader.NumTitlesGT FROM bloomreaderuser;
DROP VIEW bloomreader.NumTitlesGT CASCADE;

CREATE OR REPLACE VIEW bloomreader.NumTitlesGT AS
    SELECT COUNT( DISTINCT (d.title))
   	FROM (SELECT * FROM bloomreader.pages_read
		UNION ALL
		  SELECT * FROM bloomreaderbeta.pages_read) AS d 
		  WHERE EXISTS (SELECT 1 FROM public.ip2location AS b 
                   		WHERE ip2int(d.context_ip) BETWEEN b.ip_from and b.ip_to
						AND b.country_name = 'Guatemala') 	
				AND d.branding_project_name = 'Juarez-Guatemala';
    
GRANT SELECT ON bloomreader.NumTitlesGT TO bloomreaderuser;
select * FROM bloomreader.NumTitlesGT;
