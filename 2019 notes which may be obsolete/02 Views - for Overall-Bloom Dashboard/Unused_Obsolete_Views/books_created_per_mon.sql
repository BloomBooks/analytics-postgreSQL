/* Need to rename this to BookCreatedPerMonth  */
REVOKE SELECT ON bloomreadertest.BookCreatedPerMonth FROM readbloomtester;
DROP VIEW bloomreadertest.BookCreatedPerMonth CASCADE;

CREATE VIEW bloomreadertest.BookCreatedPerMonth AS
	SELECT COUNT(*) AS num_created,
          CAST (date_part('YEAR',
                    a.timestamp AT TIME ZONE 'AEST'       
                     ) as text)||
		  CAST (LPAD((date_part('MONTH',a.timestamp AT TIME ZONE 'AEST'))::text, 2, '0')  as text)	
					AS Month_Published,
          a.timestamp::timestamp::date,
		(SELECT d.country_name from public.ip2loc_sm_tab AS d
		   WHERE public.ip2ipv4(a.ip) = d.context_ip) AS Country
	FROM   bloomapp.create_book AS a
    GROUP BY a.timestamp, a.timestamp::timestamp::date, a.ip;

GRANT SELECT ON bloomreadertest.BookCreatedPerMonth TO readbloomtester;
select * FROM bloomreadertest.BookCreatedPerMonth;



