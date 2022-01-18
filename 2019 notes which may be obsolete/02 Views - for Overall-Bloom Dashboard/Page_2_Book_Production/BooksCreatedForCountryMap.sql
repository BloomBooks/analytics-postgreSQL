REVOKE SELECT ON bloomapp.BookCreatedforCountryMap FROM bloomappuser;
DROP VIEW bloomapp.BookCreatedforCountryMap;

CREATE VIEW bloomapp.BookCreatedforCountryMap AS
	SELECT a.user_id, a.id,
		( SELECT d.country_name
           FROM public.countryregioncitylu AS d
          WHERE a.location_uid = d.loc_uid) AS country 
	FROM   bloomapp.create_book AS a
	GROUP BY a.user_id, a.id, a.location_uid, a.country;

GRANT SELECT ON bloomapp.BookCreatedforCountryMap TO bloomappuser;
select * FROM bloomapp.BookCreatedforCountryMap;
 select * from bloomapp.BookCreatedforCountryMap AS a
     WHERE a.country ='';

 select * from public.countryregioncitylu AS d
     WHERE d.loc_uid IS NOT NULL and d.Country_code is NOT NULL and d.Country_name IS NULL;

select a.country, count(a.user_id) from bloomapp.BookCreatedforCountryMap AS a
  GROUP BY a.country ORDER BY count(a.user_id) DESC;