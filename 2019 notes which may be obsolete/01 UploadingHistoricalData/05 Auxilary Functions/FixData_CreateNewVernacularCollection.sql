--DROP FUNCTION FixData_CreateNewVernacularCollection();

CREATE OR REPLACE FUNCTION FixData_CreateNewVernacularCollection()
RETURNS SETOF varchar AS $BODY$
DECLARE err_constraint varchar(100);
DECLARE counter bigint;
DECLARE country_temp text;
DECLARE ip_temp text;
DECLARE loc_id bigint;
DECLARE xyz CURSOR FOR SELECT * from bloomapp.create_new_vernacular_collection AS a
		WHERE a.location_uid IS NOT NULL
		ORDER BY a.location_uid, a.user_id, a.timestamp;
DECLARE xyz_row RECORD;
BEGIN
FOR xyz_row IN xyz
    LOOP
	counter := 0;
	loc_id := NULL;
	country_temp := NULL;
	ip_temp := NULL;
	SELECT b.ip, b.location_uid, b.country
	FROM bloomreadertest.clone_create_new_vernacular_collection AS b 
		WHERE b.timestamp = xyz_row.timestamp
		AND b.user_id = xyz_row.user_id
		INTO ip_temp, loc_id, country_temp;
	UPDATE bloomapp.create_new_vernacular_collection AS c 
  		SET ip = ip_temp, location_uid = loc_id, country = country_temp
			WHERE c.timestamp = xyz_row.timestamp
			AND c.user_id = xyz_row.user_id;

	RETURN NEXT xyz_row.user_id;			
END LOOP;

EXCEPTION
   WHEN SQLSTATE '23000' THEN  -- Class 23 Integrity Constraint Violation
      GET STACKED DIAGNOSTICS err_constraint = CONSTRAINT_NAME;
      -- do something with it, for instance:
      RAISE NOTICE '%', err_constraint;
      RAISE;  -- raise original error
END;
$BODY$ LANGUAGE plpgsql;

-- Column: bloomreadertest.clone2_create_new_vernacular_collection.location_uid
-- ALTER TABLE bloomreadertest.clone2_create_new_vernacular_collection DROP COLUMN location_uid;
ALTER TABLE bloomreadertest.clone2_create_new_vernacular_collection
    ADD COLUMN location_uid bigint;	
--SELECT * FROM FixData_CreateNewVernacularCollection();

select count(*) from bloomapp.create_new_vernacular_collection;
SELECT * from bloomapp.create_new_vernacular_collection AS a
  WHERE location_uid = 1;
SELECT a.country,a.ip from bloomreadertest.clone_create_new_vernacular_collection AS a
  WHERE location_uid = 1;
SELECT * from bloomreadertest.mpdata_create_new_vernacular_collection AS a
       WHERE to_timestamp(a.received_at) < 
	   (SELECT MIN(b.timestamp) FROM bloomreadertest.clone2_create_new_vernacular_collection AS b) 
	   ORDER BY a.mp_country, a.region, a.city;
SELECT MIN(b.timestamp) FROM bloomreadertest.clone2_create_new_vernacular_collection AS b	   
select MAX(to_timestamp(a.received_at)) from bloomreadertest.mpdata_create_new_vernacular_collection AS a
select Count(*) from bloomapp.change_picture;
select * from bloomapp.change_picture;
select Count(*) from bloomreadertest.clone2_change_picture;
select * from bloomreadertest.clone2_change_picture;
select a.ip, a.country, a.collection_country, a.location_uid, a.timestamp 
  from bloomreadertest.clone2_change_picture AS a
  WHERE a.ip is null and a.country IS NOT NULL
  order by a.timestamp ASC, a.location_uid DESC;
select * from public.countryregioncitylu as p order by p.loc_uid DESC;
SELECT * from bloomreadertest.clone2_create_new_vernacular_collection AS a
   Where a.country = 'Ethiopia';
SELECT DISTINCT (h.country_code) FROM public.ip2loc_sm_tab AS h 
				WHERE  UPPER(h.country_name) = UPPER('Ethiopia');    
				--Japan, United States, PNG Papua New Guinea
				--  Germany, Tanzania, Venezuela
