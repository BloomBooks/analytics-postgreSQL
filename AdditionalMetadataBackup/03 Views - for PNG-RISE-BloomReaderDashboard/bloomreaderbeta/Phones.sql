REVOKE SELECT ON bloomreader.Phones FROM readbloomtester;
DROP VIEW bloomreader.Phones ;

CREATE VIEW bloomreader.Phones AS
	SELECT count(*) AS phone_count,
    a.timestamp
	FROM   bloomreader.application_installed AS a
      GROUP BY a.timestamp;
    

GRANT SELECT ON bloomreader.Phones TO readbloomtester;
select * FROM bloomreader.Phones ;