REVOKE SELECT ON bloomreadertest.NumTitles FROM readbloomtester;
DROP VIEW bloomreadertest.NumTitles CASCADE;

CREATE VIEW bloomreadertest.NumTitles AS
   SELECT DISTINCT ON (d.title) TITLE, d.timestamp, 
		  (SELECT i.country_name from public.ip2loc_sm_tab AS i
		   WHERE public.ip2int(d.context_ip) = i.context_ip
		    GROUP BY i.country_name) AS Country
    	FROM bloomreadertest.UnionPages AS d;
    
GRANT SELECT ON bloomreadertest.NumTitles TO readbloomtester;
select * FROM bloomreadertest.NumTitles;

/*  older version
REVOKE SELECT ON bloomreadertest.NumTitles FROM readbloomtester;
DROP VIEW bloomreadertest.NumTitles CASCADE;

CREATE VIEW bloomreadertest.NumTitles AS
    SELECT COUNT(*), a.booktitle, row_number() OVER (ORDER BY a.booktimestamp), a.booktimestamp, a.country
	FROM (
        SELECT COUNT(*), d.booktitle, row_number() OVER (ORDER BY d.booktimestamp), d.booktimestamp, d.country,
           RANK() OVER (partition by d.booktitle ORDER BY d.booktimestamp ASC) AS RANK
    	FROM bloomreadertest.UnionPagesRead AS d
        GROUP BY d.booktitle, d.booktimestamp, d.country 							
		  ) AS a  
	WHERE rank = 1 AND a.country = 'Papua New Guinea'
            GROUP BY a.booktitle, a.booktimestamp, a.country ;				

GRANT SELECT ON bloomreadertest.NumTitles TO readbloomtester;
select * FROM bloomreadertest.NumTitles;
*/
