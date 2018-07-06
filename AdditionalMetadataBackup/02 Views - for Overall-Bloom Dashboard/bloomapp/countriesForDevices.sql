--REVOKE SELECT ON bloomreader.countries_for_devices FROM bloomreaderuser;
DROP VIEW bloomreadertest.countries_for_devices;

CREATE VIEW bloomreadertest.countries_for_devices AS
  SELECT a.id, a.timestamp,
        ( SELECT d.country_name
           FROM countryregioncitylu AS d
          WHERE a.location_uid = d.loc_uid) AS country 
  FROM bloomreader.application_installed AS a;

GRANT SELECT ON bloomreadertest.countries_for_devices TO readbloomtester;
GRANT ALL PRIVILEGES on bloomreadertest.countries_for_devices 
		to readbloom, silpgadmin, segment, readbloomtester;
select * FROM bloomreadertest.countries_for_devices;

GRANT ALL PRIVILEGES on public.ip2location to readbloom, silpgadmin, segment, readbloomtester;
select a.context_ip FROM bloomreader.application_installed AS a;