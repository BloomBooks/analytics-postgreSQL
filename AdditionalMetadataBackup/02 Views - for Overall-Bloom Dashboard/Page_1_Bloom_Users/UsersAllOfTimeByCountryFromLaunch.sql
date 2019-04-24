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

	SELECT DISTINCT (a.user_id) FROM bloomapp.launch AS a;
	SELECT DISTINCT (a.user_id) ,
    ( SELECT DISTINCT d.country_name
           FROM countryregioncitylu AS d
          WHERE a.location_uid = d.loc_uid) AS country
    FROM bloomapp.launch AS a
    GROUP BY a.location_uid, a.user_id
    ORDER BY d.country_name, a.user_id ;

SELECT DISTINCT (a.user_id), d.country_name
    FROM public.countryregioncitylu AS d, bloomapp.launch AS a
    WHERE a.location_uid = d.loc_uid
	 GROUP BY d.country_name, a.user_id;
	
select COUNT(DISTINCT(a.user_id)) FROM bloomreadertest.UsersAllTimeFromLaunch AS a;	
	
select COUNT(a.user_id) FROM bloomreadertest.UsersAllTimeFromLaunch AS a
   WHERE a.Country IS NULL;

select COUNT(a.user_id) FROM bloomreadertest.UsersAllTimeFromLaunch AS a
   WHERE a.Country ='Philippines';

select COUNT(DISTINCT(a.user_id)) from bloomapp.launch AS a
  WHERE a.location_uid IN (select b.loc_uid from public.countryregioncitylu AS b
						 Where b.country_name = 'Bangladesh');
					  
select COUNT(DISTINCT(a.user_id)) from bloomapp.launch  AS A where a.location_uid is null;
					  
select * from bloomapp.launch  AS A where a.location_uid is null
	AND a.timestamp::timestamp::date <> '2018-07-05';
  -- AND a.timestamp> '2018-07-05 10:35:43.600';   
 
select distinct (a.context_library_name) from bloomapp.launch AS a;
							 
select COUNT(DISTINCT(a.user_id)) from bloomapp.launch AS a
  WHERE a.location_uid IN (select b.loc_uid from public.countryregioncitylu AS b
						 Where b.country_code = 'BD');

select Count(a.user_id), d.country_name from bloomapp.launch AS a
  WHERE a.location_uid IN (select b.loc_uid from public.countryregioncitylu AS b);