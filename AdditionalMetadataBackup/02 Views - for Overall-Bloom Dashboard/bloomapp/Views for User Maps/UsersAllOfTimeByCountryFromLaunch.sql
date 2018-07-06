--REVOKE SELECT ON bloomreadertest.UsersAllTimeFromLaunch FROM readbloomtester;
--DROP VIEW bloomreadertest.UsersAllTimeFromLaunch;

CREATE VIEW bloomreadertest.UsersAllTimeFromLaunch AS
	SELECT DISTINCT (a.user_id),
    ( SELECT DISTINCT d.country_name
           FROM countryregioncitylu AS d
          WHERE a.location_uid = d.loc_uid) AS country
    FROM bloomapp.launch AS a
    GROUP BY a.location_uid, a.user_id
    ORDER BY a.user_id ;
GRANT SELECT ON bloomreadertest.UsersAllTimeFromLaunch TO readbloomtester;	
SELECT * FROM bloomreadertest.UsersAllTimeFromLaunch;

select COUNT(a.user_id) FROM bloomreadertest.UsersAllTimeFromLaunch AS a
   WHERE a.Country ='Bangladesh';
   
select COUNT(DISTINCT(a.user_id)) from bloomapp.launch AS a
  WHERE a.location_uid IN (select b.loc_uid from public.countryregioncitylu AS b
						 Where b.country_name = 'Bangladesh');
   
 
select distinct (a.context_library_name) from bloomapp.launch AS a;
							 
select COUNT(DISTINCT(a.user_id)) from bloomapp.launch AS a
  WHERE a.location_uid IN (select b.loc_uid from public.countryregioncitylu AS b
						 Where b.country_code = 'BD');

select Count(a.user_id), d.country_name from bloomapp.launch AS a
  WHERE a.location_uid IN (select b.loc_uid from public.countryregioncitylu AS b);