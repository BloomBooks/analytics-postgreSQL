REVOKE SELECT ON bloomreader.PhonesAllOfTimeGT FROM readbloomtester;
DROP VIEW bloomreader.PhonesAllOfTimeGT;

CREATE or REPLACE VIEW bloomreader.PhonesAllOfTimeGT AS
    SELECT COUNT(DISTINCT (a.context_device_id)) AS phone_count
	FROM (SELECT * FROM bloomreader.pages_read
		 UNION ALL
		 SELECT * FROM bloomreaderbeta.pages_read) AS a
	WHERE a.branding_project_name = 'Juarez-Guatemala';

GRANT SELECT ON bloomreader.PhonesAllOfTimeGT TO bloomreaderuser;
select * FROM bloomreader.PhonesAllOfTimeGT;