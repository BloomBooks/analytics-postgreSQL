--REVOKE SELECT ON bloomreader.NumTitlesAll FROM bloomreaderuser;
--DROP VIEW bloomreader.NumTitlesAll CASCADE;

CREATE VIEW bloomreader.NumTitlesAll AS
   SELECT DISTINCT ON (d.title) TITLE, d.timestamp, 
		  (SELECT i.country_name from public.ip2loc_sm_tab AS i
		   WHERE public.ip2int(d.context_ip) = i.context_ip
		    GROUP BY i.country_name) AS Country
    	FROM (
			SELECT * FROM bloomreader.pages_read 
			UNION ALL
			SELECT * FROM bloomreaderbeta.pages_read) AS d;
    
GRANT SELECT ON bloomreader.NumTitlesAll TO bloomreaderuser;
select * FROM bloomreader.NumTitlesAll;