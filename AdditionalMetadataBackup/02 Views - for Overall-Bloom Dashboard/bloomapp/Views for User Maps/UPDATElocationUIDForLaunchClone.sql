--DROP FUNCTION UPDATE_LOC_UID_Launch();

CREATE OR REPLACE FUNCTION UPDATE_LOC_UID_Launch()
RETURNS SETOF varchar AS $BODY$
DECLARE err_constraint varchar(100);
DECLARE country_code_temp varchar(2);
DECLARE country_name_temp varchar(64);
DECLARE region_temp varchar(100);
DECLARE city_temp varchar(100);
DECLARE hold_country_code varchar(2);
DECLARE hold_country_name varchar(64);
DECLARE hold_region varchar(100);
DECLARE hold_city varchar(100);
DECLARE loc_uid_temp bigint;
DECLARE counter bigint;
DECLARE xyz CURSOR FOR SELECT * from bloomapp.launch AS a
		WHERE a.location_uid IS NULL;
/*      WHERE a.timestamp > '2017-07-21 19:42:16.883+00' 
	  AND a.ip IS NOT NULL 
	  AND (STRPOS(a.ip,'<') = 0)  
	  AND (STRPOS(a.ip,':') = 0);
	  */
DECLARE xyz_row RECORD;
BEGIN

SELECT MAX(c.loc_uid) FROM public.countryregioncitylu AS c INTO counter;

FOR xyz_row IN xyz
    LOOP
	country_code_temp := NULL;
	country_name_temp := NULL;
	region_temp := NULL;
	city_temp := NULL;
	hold_country_code := NULL;
	hold_country_name := NULL;
	hold_region := NULL;
	hold_city := NULL;	
		IF country_code_temp ='-' or public.empty_to_null(country_code_temp) IS NULL THEN 
	   		country_code_temp := '-';
		END IF;	
		IF country_name_temp ='-' or public.empty_to_null(country_name_temp) IS NULL THEN 
	   		country_name_temp := '-';
		END IF;			
		IF region_temp ='-' or public.empty_to_null(region_temp) IS NULL THEN 
	   		region_temp := '-';
		END IF;
		IF city_temp ='-' or public.empty_to_null(city_temp) IS NULL THEN 
	   		city_temp := '-';
		END IF;		
	IF public.empty_to_null(xyz_row.ip) IS NOT NULL THEN
		SELECT c.country_code, c.country_name, c.region, c.city 
	    	FROM public.ip2loc_sm_tab AS c WHERE public.ip2ipv4(xyz_row.ip) = c.context_ip
		INTO hold_country_code, hold_country_name, hold_region, hold_city;
		IF hold_country_code IS NULL THEN
			hold_country_name := NULL;
			hold_region := NULL;
			hold_city := NULL;	
			SELECT f.country_code, f.country_name, f.region, f.city 
	    		FROM public.ipv42location AS f WHERE public.ip2ipv4(xyz_row.ip) 
			BETWEEN f.ipv4_from AND f.ipv4_to
			INTO hold_country_code, hold_country_name, hold_region, hold_city;		
		END IF;
		country_code_temp := hold_country_code; 
		country_name_temp := hold_country_name;
		region_temp := hold_region;
		city_temp :=  hold_city;
		IF country_code_temp ='-' or public.empty_to_null(country_code_temp) IS NULL THEN 
	   		country_code_temp := '-';
		END IF;	
		IF country_name_temp ='-' or public.empty_to_null(country_name_temp) IS NULL THEN 
	   		country_name_temp := '-';
		END IF;			
		IF region_temp ='-' or public.empty_to_null(region_temp) IS NULL THEN 
	   		region_temp := '-';
		END IF;
		IF city_temp ='-' or public.empty_to_null(city_temp) IS NULL THEN 
	   		city_temp := '-';
		END IF;	
	END IF;
	loc_uid_temp := NULL;
	SELECT i.loc_uid from public.countryregioncitylu AS i
		where i.country_code = country_code_temp
		AND i.region = region_temp
		AND i.city = city_temp
		INTO loc_uid_temp;
	IF loc_uid_temp IS NULL THEN
        	counter := counter + CAST('1' AS bigint);
		loc_uid_temp := counter ;
		INSERT INTO  public.countryregioncitylu as p  
		( loc_uid, country_code, country_name, region, city  )  
		VALUES
		( loc_uid_temp, country_code_temp, country_name_temp, region_temp, city_temp ) ;
	END IF;

   	UPDATE bloomapp.launch 
	SET  location_uid = loc_uid_temp
	WHERE id = xyz_row.id;
     	
	RETURN NEXT xyz_row.id;			
END LOOP;

EXCEPTION
   WHEN SQLSTATE '23000' THEN  -- Class 23 Integrity Constraint Violation
      GET STACKED DIAGNOSTICS err_constraint = CONSTRAINT_NAME;
      -- do something with it, for instance:
      RAISE NOTICE '%', err_constraint;
      RAISE;  -- raise original error
END;
$BODY$ LANGUAGE plpgsql;

-- Column: bloomapp.launch.location_uid
-- ALTER TABLE bloomapp.launch DROP COLUMN location_uid;
ALTER TABLE bloomapp.launch 
    ADD COLUMN location_uid bigint;	
	
SELECT MIN(b.timestamp) FROM bloomapp.launch AS b

--SELECT * FROM UPDATE_LOC_UID_Launch();
select count(*) from bloomapp.launch;
select count(*) from bloomreadertest.mpdata_launch;
select * from bloomreadertest.mpdata_launch AS a
 where a.language3_iso639_name IS NOT NULL;
SELECT * from bloomreadertest.mpdata_launch AS a;
SELECT * from bloomreadertest.mpdata_launch AS a
       WHERE to_timestamp(a.received_at) < 
	   (SELECT MIN(b.timestamp) FROM bloomreadertest.clone_change_picture AS b) 
	   ORDER BY a.mp_country, a.region, a.city;

select DISTINCT(a.location_uid), COUNT(a.location_uid) from bloomreadertest.clone_launch AS a
  GROUP BY a.location_uid;
 WHERE a.location_uid IS NULL;
select * from bloomapp.change_video;
select to_timestamp(1523004075 );
select Count(*) from bloomapp.change_picture;
select * from bloomapp.change_picture;
select Count(*) from bloomreadertest.clone_change_picture;
select * from bloomreadertest.clone_change_picture;
select a.ip, a.country, a.collection_country, a.location_uid, a.timestamp 
  from bloomreadertest.clone_change_picture AS a
  WHERE a.ip is null and a.country IS NOT NULL
  order by a.timestamp ASC, a.location_uid DESC;
select * from public.countryregioncitylu as p 
WHERE country_code = 'BD'
order by p.loc_uid DESC;

public.countryregioncitylu

select a.countryname from public.countrycodes AS a where a.countrycode = 'TL';
SELECT * from bloomapp.launch AS a
		WHERE a.location_uid IS NULL;
select COUNT(DISTINCT(a.user_id)) from bloomreadertest.clone_launch AS a
  WHERE a.location_uid IN (select b.loc_uid from public.countryregioncitylu AS b
						 Where b.country_code = 'BD');