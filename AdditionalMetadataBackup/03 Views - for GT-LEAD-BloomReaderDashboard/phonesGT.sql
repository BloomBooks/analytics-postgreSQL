REVOKE SELECT ON bloomreader.phonesGT FROM readbloomtester;
DROP VIEW bloomreader.phonesGT;

CREATE or REPLACE VIEW bloomreader.phonesGT AS
    SELECT COUNT(DISTINCT (a.context_device_id)) AS recuento_de_aparatos,
        a.timestamp 
	FROM (SELECT * FROM bloomreader.pages_read
		 UNION ALL
		 SELECT * FROM bloomreaderbeta.pages_read) AS a
	WHERE a.branding_project_name = 'Juarez-Guatemala'
	GROUP BY a.timestamp;

GRANT SELECT ON bloomreader.phonesGT TO readbloomtester;
select * FROM bloomreader.phonesGT;

/*
    SELECT COUNT(DISTINCT (a.context_device_id)) AS recuento_de_aparatos,
        a.timestamp 
	FROM (SELECT * FROM bloomreader.pages_read) AS a
	WHERE a.branding_project_name = 'Juarez-Guatemala'
	GROUP BY a.timestamp
		UNION ALL
    SELECT COUNT(DISTINCT (b.context_device_id)) AS recuento_de_aparatos,
        b.timestamp 
	FROM (SELECT * FROM bloomreaderbeta.pages_read) AS b
	WHERE b.branding_project_name = 'Juarez-Guatemala'
	GROUP BY b.timestamp;		

*/
/*ORIGINALLY it was
CREATE VIEW bloomreader.phonesGT AS
	SELECT count(*) AS phone_count,
    		a.timestamp
	FROM   bloomreader.application_installed AS a
	WHERE  EXISTS (SELECT 1 FROM public.ip2location AS b 
                   WHERE ip2int(a.context_ip) BETWEEN b.ip_from and b.ip_to
			AND b.country_name = 'Guatemala')
            GROUP BY a.timestamp;*/
	
/* 1st attempt to implement in Spanish.
CREATE VIEW bloomreader.phonesGT AS
	SELECT count(*) AS recuento_de_aparatos,
    a.timestamp
	FROM   bloomreader.application_installed AS a
	WHERE  EXISTS (SELECT 1 FROM public.ip2location AS b 
                   WHERE ip2int(a.context_ip) BETWEEN b.ip_from and b.ip_to
			AND b.country_name = 'Guatemala')
            GROUP BY a.timestamp;
*/    

