--DROP FUNCTION UPDATE_LOC_UID_Country();

CREATE OR REPLACE FUNCTION UPDATE_LOC_UID_Country()
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
DECLARE xyz CURSOR FOR SELECT * from public.countryregioncitylu AS a
		WHERE a.country_code <> '-'
		AND a.country_name = '-';
/*      WHERE a.timestamp > '2017-07-21 19:42:16.883+00' 
	  AND a.ip IS NOT NULL 
	  AND (STRPOS(a.ip,'<') = 0)  
	  AND (STRPOS(a.ip,':') = 0);
	  */
DECLARE xyz_row RECORD;
BEGIN
FOR xyz_row IN xyz
    LOOP
	country_name_temp := NULL;
	SELECT b.countryname FROM public.countrycodes AS b 
	WHERE b.countrycode = xyz_row.country_code
	INTO country_name_temp;

    IF country_name_temp ='-' or public.empty_to_null(country_name_temp) IS NULL THEN 
	   	country_name_temp := '-';
	END IF;	

   	UPDATE public.countryregioncitylu
	SET  country_name = country_name_temp
	WHERE loc_uid = xyz_row.loc_uid;
     	
	RETURN NEXT xyz_row.country_code;			
END LOOP;

EXCEPTION
   WHEN SQLSTATE '23000' THEN  -- Class 23 Integrity Constraint Violation
      GET STACKED DIAGNOSTICS err_constraint = CONSTRAINT_NAME;
      -- do something with it, for instance:
      RAISE NOTICE '%', err_constraint;
      RAISE;  -- raise original error
END;
$BODY$ LANGUAGE plpgsql;

--SELECT * FROM UPDATE_LOC_UID_Country();

select * 
SELECT * from public.countryregioncitylu AS a
		WHERE a.country_code <> '-'
		AND a.country_name = '-';
SELECT * from public.countryregioncitylu AS a
		WHERE a.country_code ='TN'