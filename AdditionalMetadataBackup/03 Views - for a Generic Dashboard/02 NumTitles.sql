REVOKE SELECT ON bloomreader.NumTitles FROM bloomreaderuser;
DROP VIEW bloomreader.NumTitles CASCADE;

CREATE VIEW bloomreader.NumTitles AS
    SELECT COUNT(*), a.title, row_number() OVER (ORDER BY a.timestamp), a.timestamp, a.Country
	FROM (
        SELECT COUNT(*), d.title, row_number() OVER (ORDER BY d.timestamp), d.timestamp, 
		  (SELECT i.country_name from public.ip2loc_sm_tab AS i
		   WHERE public.ip2int(d.context_ip) = i.context_ip
		    GROUP BY i.country_name) AS Country,											
           RANK() OVER (partition by d.title ORDER BY d.timestamp ASC) AS RANK
    	FROM (SELECT * FROM bloomreader.pages_read
				UNION ALL
				SELECT * FROM bloomreaderbeta.pages_read) AS d
        GROUP BY d.title, d.timestamp, d.country_name, d.context_ip
		  ) AS a  
	WHERE rank = 1 
	GROUP BY a.title, a.timestamp, a.Country;
    
GRANT SELECT ON bloomreader.NumTitles TO bloomreaderuser;
select * FROM bloomreader.NumTitles;


