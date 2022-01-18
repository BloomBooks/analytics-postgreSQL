REVOKE SELECT ON bloomreader.allDevices FROM bloomreaderuser;
DROP VIEW bloomreader.allDevices CASCADE;

CREATE VIEW bloomreader.allDevices AS
	SELECT * FROM (
		SELECT count(*) AS device_count,
    			a.timestamp
			FROM bloomreader.application_installed AS a
    			GROUP BY a.timestamp) AS c
	UNION ALL
	SELECT * FROM (
		SELECT count(*) AS device_count,
    			b.timestamp
			FROM bloomreaderbeta.application_installed AS b
    			GROUP BY b.timestamp) AS d;   

GRANT SELECT ON bloomreader.allDevices TO bloomreaderuser;
select * FROM bloomreader.allDevices;