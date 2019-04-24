REVOKE SELECT ON bloomreader.phonesPNG FROM readbloomtester;
DROP VIEW bloomreader.phonesPNG;

CREATE VIEW bloomreader.phonesPNG AS
	SELECT count(*) AS phone_count,
    a.timestamp
	FROM   bloomreader.application_installed AS a
	WHERE  EXISTS (SELECT 1 FROM public.ip2location AS b 
                   WHERE ip2int(a.context_ip) BETWEEN b.ip_from and b.ip_to
			AND b.country_name = 'Papua New Guinea')
            GROUP BY a.timestamp;
    

GRANT SELECT ON bloomreader.phonesPNG TO readbloomtester;
select * FROM bloomreader.phonesPNG;