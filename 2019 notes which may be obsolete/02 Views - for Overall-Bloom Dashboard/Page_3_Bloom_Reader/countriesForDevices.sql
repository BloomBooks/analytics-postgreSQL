--REVOKE SELECT ON bloomreader.countries_for_devices FROM bloomreaderuser;
--DROP VIEW bloomreader.countries_for_devices;

CREATE VIEW bloomreader.countries_for_devices AS
  SELECT a.id, a.timestamp,
        ( SELECT d.country_name
           FROM countryregioncitylu AS d
          WHERE a.location_uid = d.loc_uid) AS country 
  FROM bloomreader.application_installed AS a;

GRANT SELECT ON bloomreader.countries_for_devices TO bloomreaderuser;
select * FROM bloomreader.countries_for_devices;