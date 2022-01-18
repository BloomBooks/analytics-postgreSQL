--DROP FUNCTION populate_missing_city_region_ip2loc_sm_tab();

CREATE OR REPLACE FUNCTION populate_missing_city_region_ip2loc_sm_tab()
RETURNS SETOF varchar AS $BODY$
DECLARE ip bigint;
DECLARE hold_region varchar(100);
DECLARE hold_city varchar(100);
DECLARE counter bigint;
DECLARE xyz CURSOR FOR SELECT distinct (a.country_code, a.region, a.city), 
   			FROM public.ip2loc_sm_tab AS a
   			WHERE a.city is NULL;
DECLARE xyz_row RECORD;
BEGIN
 SELECT MAX(loc_uid)+CAST('1' AS bigint) from public.ip2loc_sm_tab INTO counter;
FOR xyz_row IN xyz
    LOOP
	    SELECT a.region, a.city from public.ipv42location AS a 
			WHERE xyz_row.context_ip BETWEEN ipv4_from AND ipv4_to
			INTO hold_region, hold_city;
	
		UPDATE public.ip2loc_sm_tab  
		SET loc_uid = counter, city = hold_city, region = hold_region
		   WHERE context_ip = xyz_row.context_ip ;
		counter := counter + CAST('1' AS bigint);
		RETURN NEXT xyz_row.context_ip;
	END LOOP;
END;
$BODY$ LANGUAGE plpgsql; 

select * from populate_missing_city_region_ip2loc_sm_tab();

SELECT * from public.ip2loc_sm_tab WHERE city is Null;
select MAX (loc_uid) from public.ip2loc_sm_tab ;
select * from public.ip2loc_sm_tab  WHERE  loc_uid IS NULL;
