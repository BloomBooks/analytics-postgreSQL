--REVOKE SELECT ON bloomreadertest.UsersAllTimeFromRegister FROM readbloomtester;
--DROP VIEW bloomreadertest.UsersAllTimeFromRegister;

CREATE VIEW bloomreadertest.UsersAllTimeFromRegister AS
	SELECT DISTINCT (a.user_id),
    ( SELECT DISTINCT d.country_name
           FROM countryregioncitylu AS d
          WHERE a.location_uid = d.loc_uid) AS country
    FROM bloomapp.register AS a
    GROUP BY a.location_uid, a.user_id
    ORDER BY a.user_id ;
GRANT SELECT ON bloomreadertest.UsersAllTimeFromRegister TO readbloomtester;	
SELECT * FROM bloomreadertest.UsersAllTimeFromRegister;

select COUNT(a.user_id) FROM bloomreadertest.UsersAllTimeFromRegister AS a
   WHERE a.Country IS NULL;

select COUNT(a.user_id) FROM bloomreadertest.UsersAllTimeFromRegister AS a
   WHERE a.Country ='Philippines';