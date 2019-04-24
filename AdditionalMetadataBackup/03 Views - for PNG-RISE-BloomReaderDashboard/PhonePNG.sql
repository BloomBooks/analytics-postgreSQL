REVOKE SELECT ON bloomreader.PhonesPNG FROM bloomreaderuser;
DROP VIEW bloomreader.PhonesPNG ;

CREATE OR REPLACE VIEW bloomreader.phonespng AS
	SELECT * FROM 
           (SELECT count(*) AS phone_count, a.timestamp
		FROM bloomreader.application_installed AS a
		WHERE EXISTS (SELECT 1 FROM public.ip2location AS b 
                   WHERE ip2int(a.context_ip) 
				BETWEEN b.ip_from and b.ip_to
				AND b.country_name = 'Papua New Guinea')
            		GROUP BY a.timestamp) AS c
	UNION ALL
	SELECT * FROM 
		(SELECT count(*) AS phone_count, d.timestamp
		FROM bloomreaderbeta.application_installed AS d
		WHERE EXISTS (SELECT 1 FROM public.ip2location AS e 
                   WHERE ip2int(d.context_ip) 
				BETWEEN e.ip_from and e.ip_to
				AND e.country_name = 'Papua New Guinea')
            		GROUP BY d.timestamp) AS f;    

GRANT SELECT ON bloomreader.PhonesPNG TO bloomreaderuser;
select * FROM bloomreader.PhonesPNG ;
