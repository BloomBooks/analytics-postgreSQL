--DROP FUNCTION populate_missing_country_ip2loc_sm_tab();

CREATE OR REPLACE FUNCTION populate_missing_country_ip2loc_sm_tab()
RETURNS SETOF varchar AS $BODY$
DECLARE country_code_temp varchar(2);
DECLARE country_name_temp varchar(64);
DECLARE counter bigint;
DECLARE xyz CURSOR FOR SELECT distinct (a.country_code, a.region, a.city), 
			a.country_name, a.region, a.city 
   	FROM public.ip2loc_sm_tab AS a
	WHERE country_code = '-';
DECLARE xyz_row RECORD;
BEGIN
FOR xyz_row IN xyz
    LOOP
        country_code_temp := '-';
	country_name_temp := '-';
        SELECT country_code, country_name from ipv42location 
          WHERE region = xyz_row.region and city = xyz_row.city
          INTO country_code_temp, country_name_temp ;
		UPDATE public.ip2loc_sm_tab  
		SET country_code = country_code_temp, country_name = country_name_temp 
		WHERE region = xyz_row.region
		   AND city = xyz_row.city;
	RETURN NEXT xyz_row.country_name;
END LOOP;
END;
$BODY$ LANGUAGE plpgsql; 

select * from populate_missing_country_ip2loc_sm_tab();
select * from public.ip2loc_sm_tab
  WHERE country_code ='-';
select Count(*) from public.ipv42location as a where a.country_region_city_id is not null;
select country_region_city_id, country_name, region, city from public.ipv42location as a 
     where a.country_region_city_id is not null; 
select * from public.ipv42loc ORDER BY ipv4_from ASC LIMIT 100;
select Count(*) from public.ipv42location ;
select max(loc_uid), Count(context_ip) from public.ip2loc_sm_tab;
select  distinct (country_code, region, city), country_code, region, city from public.ip2loc_sm_tab;
select max(loc_uid) from public.ip2loc_sm_tab;
SELECT * from public.ip2loc_sm_tab AS a
   ORDER BY country_code ASC, region ASC, city ASC;
   
   
   
   select country_code, region, city from 