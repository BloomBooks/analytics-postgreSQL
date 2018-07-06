/* Need to rename this to BookCreatedPerMonth  */
REVOKE SELECT ON bloomreadertest.BookCreatedforCountryMap FROM readbloomtester;
DROP VIEW bloomreadertest.BookCreatedforCountryMap;

CREATE VIEW bloomreadertest.BookCreatedforCountryMap AS
	SELECT a.user_id, a.id,
		( SELECT d.country_name
           FROM public.countryregioncitylu AS d
          WHERE a.location_uid = d.loc_uid) AS country 
	FROM   bloomapp.create_book AS a
	GROUP BY a.user_id, a.id, a.location_uid, a.country;

GRANT SELECT ON bloomreadertest.BookCreatedforCountryMap TO readbloomtester;
select * FROM bloomreadertest.BookCreatedforCountryMap;
 select * from bloomreadertest.BookCreatedforCountryMap AS a
     WHERE a.country ='';

 select * from public.countryregioncitylu AS d
     WHERE d.loc_uid IS NOT NULL and d.Country_code is NOT NULL and d.Country_name IS NULL;

select a.country, count(a.user_id) from bloomreadertest.BookCreatedforCountryMap AS a
  GROUP BY a.country ORDER BY count(a.user_id) DESC;