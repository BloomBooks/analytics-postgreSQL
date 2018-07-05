--DROP FUNCTION populate_loc_uid_ip2loc_sm_tab2();

CREATE OR REPLACE FUNCTION populate_loc_uid_ip2loc_sm_tab2()
RETURNS SETOF varchar AS $BODY$
DECLARE hold_loc_uid bigint;
DECLARE country_cur varchar(64);
DECLARE region_cur varchar(100);
DECLARE city_cur varchar(100);
DECLARE hold_country varchar(64);
DECLARE hold_region varchar(100);
DECLARE hold_city varchar(100);
DECLARE counter bigint;
DECLARE xyz CURSOR FOR SELECT distinct (a.country_code, a.region, a.city), 
			a.country_code, a.region, a.city
   			FROM public.ip2loc_sm_tab AS a
			WHERE loc_uid IS NULL
   			ORDER BY a.country_code ASC, a.region ASC, a.city ASC;
DECLARE xyz_row RECORD;
BEGIN
counter := 1627;
FOR xyz_row IN xyz
    LOOP
 	hold_loc_uid := NULL;
	SELECT b.loc_uid from public.ip2loc_sm_tab AS b
		WHERE b.country_code = xyz_row.country_code
		AND b.region = xyz_row.region
		AND b.city = xyz_row.city
		AND b.loc_uid IS NOT NULL
		INTO hold_loc_uid;
        IF hold_loc_uid IS NULL THEN
                counter := counter + CAST('1' AS bigint);
		hold_loc_uid := counter ;
	END IF;
		UPDATE public.ip2loc_sm_tab  
		SET loc_uid = hold_loc_uid 
		   WHERE country_code = xyz_row.country_code 
		   AND region = xyz_row.region
		   AND city = xyz_row.city;
		RETURN NEXT xyz_row.country_code;
	END LOOP;
END;
$BODY$ LANGUAGE plpgsql; 

select * from populate_loc_uid_ip2loc_sm_tab2();

select * from public.ip2loc_sm_tab
  WHERE loc_uid IS NULL;
select max(loc_uid) from public.ip2loc_sm_tab;
select  distinct (country_code, region, city), 
	country_code, region, city from public.ip2loc_sm_tab;
select max(loc_uid) from public.ip2loc_sm_tab;
SELECT * from public.ip2loc_sm_tab AS a
   ORDER BY loc_uid DESC, country_code ASC, region ASC, city ASC;
   