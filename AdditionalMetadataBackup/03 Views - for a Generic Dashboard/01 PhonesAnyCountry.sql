REVOKE SELECT ON bloomreader.phones_AnyCountry FROM readbloomtester;
DROP VIEW bloomreader.phones_AnyCountry ;

CREATE VIEW bloomreader.phones_AnyCountry AS
	SELECT a.context_device_id AS context_device_id,   
	       a.timestamp,
		   b.country_name AS country
	FROM   bloomreader.application_installed AS a
	INNER JOIN (SELECT DISTINCT d.country_name, d.loc_uid 
            FROM countryregioncitylu AS d) AS b ON 
            a.location_uid = b.loc_uid
     GROUP BY a.context_device_id, a.timestamp, b.country_name 
	UNION ALL
	SELECT a.context_device_id AS context_device_id,  
	       a.timestamp,
		   b.country_name AS country
	FROM   bloomreaderbeta.application_installed AS a
	INNER JOIN (SELECT DISTINCT d.country_name, d.loc_uid 
            FROM countryregioncitylu AS d) AS b ON 
            a.location_uid = b.loc_uid
     GROUP BY a.context_device_id, a.timestamp, b.country_name;
	 
GRANT SELECT ON bloomreader.phones_AnyCountry TO readbloomtester;
GRANT SELECT ON bloomreader.phones_AnyCountry TO bloomreaderuser;
select * FROM bloomreader.phones_AnyCountry AS a where a.Country= 'Guatemala';

select a.context_device_id, a.timestamp from bloomreader.application_installed AS a
WHERE a.context_device_id ='14889db96227bc0';

Select * from countryregioncitylu AS b ;
