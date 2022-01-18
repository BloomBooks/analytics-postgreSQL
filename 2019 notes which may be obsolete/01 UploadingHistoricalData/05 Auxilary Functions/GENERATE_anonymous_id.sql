--DROP FUNCTION GENERATE_anonymous_id();

CREATE OR REPLACE FUNCTION GENERATE_anonymous_id()
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
DECLARE xyz CURSOR FOR SELECT DISTINCT(a.user_id) from bloomreadertest.mpdata_preview AS a
	   ORDER BY a.user_id;
DECLARE xyz_row RECORD;
BEGIN
new_id := NULL;
FOR xyz_row IN xyz
    LOOP
	new_id := NULL;
	SELECT gen_random_uuid() INTO new_id;

   	UPDATE bloomreadertest.mpdata_preview
	SET  anonymous_id = new_id
	WHERE user_id = xyz_row.user_id;

	RETURN NEXT xyz_row.user_id;			
END LOOP;

EXCEPTION
   WHEN SQLSTATE '23000' THEN  -- Class 23 ? Integrity Constraint Violation
      GET STACKED DIAGNOSTICS err_constraint = CONSTRAINT_NAME;
      -- do something with it, for instance:
      RAISE NOTICE '%', err_constraint;
      RAISE;  -- raise original error
END;
$BODY$ LANGUAGE plpgsql;
	
--SELECT * FROM GENERATE_anonymous_id();

SELECT DISTINCT(a.user_id) from bloomreadertest.mpdata_preview AS a
	   ORDER BY a.user_id;


SELECT DISTINCT(a.anonymous_id) from bloomreadertest.mpdata_preview AS a

