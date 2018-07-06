REVOKE SELECT ON bloomreaderbeta.allDevices FROM readbloomtester;
DROP VIEW bloomreaderbeta.allDevices;

CREATE VIEW bloomreaderbeta.allDevices AS
	SELECT count(*) AS device_count,
    a.timestamp
	FROM bloomreaderbeta.application_installed AS a
    GROUP BY a.timestamp;  

GRANT SELECT ON bloomreaderbeta.allDevices TO readbloomtester;
select * FROM bloomreaderbeta.allDevices;