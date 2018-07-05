--DROP FUNCTION populate_loc_uid_ip2loc_sm_tab();

CREATE OR REPLACE FUNCTION populate_loc_uid_ip2loc_sm_tab()
RETURNS SETOF varchar AS $BODY$
DECLARE country_cur varchar(64);
DECLARE region_cur varchar(100);
DECLARE city_cur varchar(100);
DECLARE hold_country varchar(64);
DECLARE hold_region varchar(100);
DECLARE hold_city varchar(100);
DECLARE counter bigint;
DECLARE xyz CURSOR FOR SELECT distinct (a.country_code, a.region, a.city), 
			a.country_name, a.region, a.city
   			FROM public.ip2loc_sm_tab AS a
   			ORDER BY a.country_name ASC, a.region ASC, a.city ASC;
DECLARE xyz_row RECORD;
BEGIN
counter := 1;
FOR xyz_row IN xyz
    LOOP
		UPDATE public.ip2loc_sm_tab  
		SET loc_uid = counter
		   WHERE country_name = xyz_row.country_name 
		   AND region = xyz_row.region
		   AND city = xyz_row.city;
		counter := counter + CAST('1' AS bigint);
		RETURN NEXT xyz_row.country_name;
	END LOOP;
END;
$BODY$ LANGUAGE plpgsql; 

select * from populate_loc_uid_ip2loc_sm_tab();

select * from public.ip2loc_sm_tab
  WHERE country_code ='-';
select max(loc_uid), Count(context_ip) from public.ip2loc_sm_tab;
select  distinct (country_code, region, city), 
	country_code, region, city from public.ip2loc_sm_tab;
select max(loc_uid) from public.ip2loc_sm_tab;
SELECT * from public.ip2loc_sm_tab AS a
   ORDER BY country_code ASC, region ASC, city ASC;