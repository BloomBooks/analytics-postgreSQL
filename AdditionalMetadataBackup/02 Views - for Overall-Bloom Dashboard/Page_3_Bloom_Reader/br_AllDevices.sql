REVOKE SELECT ON bloomreader.allDevices FROM readbloomtester;
DROP VIEW bloomreader.allDevices;

CREATE VIEW bloomreader.allDevices AS
	SELECT count(*) AS device_count,
    a.timestamp
	FROM bloomreader.application_installed AS a
    GROUP BY a.timestamp;  

GRANT SELECT ON bloomreader.allDevices TO readbloomtester;
select * FROM bloomreader.allDevices;