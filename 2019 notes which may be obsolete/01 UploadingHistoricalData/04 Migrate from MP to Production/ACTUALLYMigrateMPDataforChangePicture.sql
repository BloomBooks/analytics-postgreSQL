﻿--DROP FUNCTION ACTUALLYMigrateMPDataforChangePicture();

CREATE OR REPLACE FUNCTION ACTUALLYMigrateMPDataforChangePicture()
RETURNS SETOF varchar AS $BODY$
DECLARE time_max_for_historical_data timestamp;
DECLARE new_id varchar(1024);
DECLARE err_constraint varchar(100);
DECLARE country_code_temp varchar(2);
DECLARE country_name_temp varchar(64);
DECLARE region_temp varchar(100);
DECLARE city_temp varchar(100);
DECLARE loc_uid_temp bigint;
DECLARE counter bigint;
DECLARE xyz CURSOR FOR SELECT * from bloomreadertest.mpdata_change_picture AS a
      -- WHERE to_timestamp(a.received_at) < time_max_for_historical_data 
	   ORDER BY a.mp_country, a.region, a.city;
DECLARE xyz_row RECORD;
BEGIN
new_id := '';
SELECT MAX(c.loc_uid) FROM public.countryregioncitylu AS c INTO counter;
--SELECT MIN(b.timestamp) FROM bloomreadertest.change_picture AS b 
--		into time_max_for_historical_data ;
FOR xyz_row IN xyz
    LOOP
	new_id := '';
	country_code_temp := NULL;
	country_name_temp := NULL;
	region_temp := NULL;
	city_temp := NULL;
	SELECT gen_random_uuid() INTO new_id;
	IF xyz_row.ip IS NOT NULL THEN
		SELECT d.country_code, d.country_name, d.region, d.city 
	    FROM public.ipv42location AS d WHERE public.ip2int(COALESCE(xyz_row.ip,'0.0.0.0')) between d.ipv4_from and d.ipv4_to
		into country_code_temp, country_name_temp, region_temp, city_temp;
	END IF; 
	IF country_code_temp IS NULL THEN 
       country_code_temp := xyz_row.mp_country;
	END IF;
	IF region_temp IS NULL THEN 
       region_temp := xyz_row.region;
	END IF;
	IF city_temp IS NULL THEN 
       city_temp := xyz_row.city;
	END IF;	
	IF country_code_temp ='' or country_code_temp ='-' or country_code_temp IS NULL THEN  
	   country_code_temp := '-';
	END IF;
	select DISTINCT(c.country_name) from public.countryregioncitylu AS c
		where c.country_code = country_code_temp INTO country_name_temp;
	IF country_name_temp ='' or country_name_temp ='-' or country_name_temp IS NULL THEN 
	   country_name_temp := '-';
	END IF;
	IF region_temp ='' or region_temp ='-' or region_temp IS NULL THEN 
	   region_temp := '-';
	END IF;
	IF city_temp ='' or city_temp ='-' or city_temp IS NULL THEN 
	   city_temp := '-';
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

   	INSERT INTO  bloomapp.change_picture as s  
	( id, received_at, browser, channel, command_line, context_library_name, 
	  context_library_version, culture,
      	  current_directory, desktop_environment, dot_net_version, event, event_text, 
	  full_version, original_timestamp,
          osversion, sent_at, timestamp, user_id, user_name, version, 
	  working_set, 
	  location_uid )
	VALUES
	(new_id, to_timestamp(xyz_row.received_at), public.empty_to_null(xyz_row.browser), 
	  public.empty_to_null(xyz_row.channel), 
	  public.empty_to_null(xyz_row.command_line), public.empty_to_null(xyz_row.context_library_name), 
	  public.empty_to_null(xyz_row.context_library_version), public.empty_to_null(xyz_row.culture), 
	  public.empty_to_null(xyz_row.current_directory), 
	  public.empty_to_null(xyz_row.desktop_environment), public.empty_to_null(xyz_row.dot_net_version), 
	  public.empty_to_null(xyz_row.event), public.empty_to_null(xyz_row.event_text), 
	  public.empty_to_null(xyz_row.full_version), 
	  to_timestamp(xyz_row.received_at), public.empty_to_null(xyz_row.osversion), 
	  to_timestamp(xyz_row.received_at), to_timestamp(xyz_row.received_at),
	  public.empty_to_null(xyz_row.user_id), public.empty_to_null(initcap(xyz_row.user_name)), 
	  public.empty_to_null(xyz_row.version), public.empty_to_null(xyz_row.working_set), 
	  loc_uid_temp );
     	--ON CONFLICT ON CONSTRAINT clone_change_picture_pkey DO NOTHING;
	RETURN NEXT xyz_row.mp_country;			
END LOOP;

EXCEPTION
   WHEN SQLSTATE '23000' THEN  -- Class 23  Integrity Constraint Violation
      GET STACKED DIAGNOSTICS err_constraint = CONSTRAINT_NAME;
      -- do something with it, for instance:
      RAISE NOTICE '%', err_constraint;
      RAISE;  -- raise original error
END;
$BODY$ LANGUAGE plpgsql;

-- Column: bloomapp.change_picture .location_uid
-- ALTER TABLE bloomapp.change_picture DROP COLUMN location_uid;
ALTER TABLE bloomapp.change_picture 
    ADD COLUMN location_uid bigint;	
--SELECT * FROM ACTUALLYMigrateMPDataforChangePicture();

select count(*) from bloomapp.change_picture;
SELECT * from bloomreadertest.clone_change_picture AS a;
SELECT * from bloomreadertest.mpdata_change_picture AS a
       WHERE to_timestamp(a.received_at) < 
	   (SELECT MIN(b.timestamp) FROM bloomreadertest.clone_change_picture AS b) 
	   ORDER BY a.mp_country, a.region, a.city;

select Count(*) from bloomapp.change_picture;
select * from bloomapp.change_picture;
select Count(*) from bloomreadertest.clone_change_picture;
select * from bloomreadertest.clone_change_picture;
select a.ip, a.country, a.collection_country, a.location_uid, a.timestamp 
  from bloomreadertest.clone_change_picture AS a
  WHERE a.ip is null and a.country IS NOT NULL
  order by a.timestamp ASC, a.location_uid DESC;
select * from public.countryregioncitylu as p order by p.loc_uid DESC;


