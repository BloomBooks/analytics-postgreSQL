REVOKE SELECT ON bloomreadertest.phonesPNG FROM readbloomtester;
DROP VIEW bloomreadertest.phonesPNG;

CREATE VIEW bloomreadertest.phonesPNG AS
	SELECT count(*) AS phone_count,
    		a.timestamp
	FROM   bloomreadertest.application_installed AS a
	WHERE  EXISTS (SELECT 1 FROM public.ip2location AS b 
                   WHERE ip2int(a.context_ip) BETWEEN b.ip_from and b.ip_to
			AND b.country_name = 'Papua New Guinea')
            GROUP BY a.timestamp;
    

GRANT SELECT ON bloomreadertest.phonesPNG TO readbloomtester;
select * FROM bloomreadertest.phonesPNG;
