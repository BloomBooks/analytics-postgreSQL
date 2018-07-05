--DROP FUNCTION populate_country_region_city_id_ipv4();

CREATE OR REPLACE FUNCTION populate_country_region_city_id_ipv4()
RETURNS SETOF varchar AS $BODY$
DECLARE country_temp varchar(64);
DECLARE region_temp varchar(100);
DECLARE city_temp varchar(100);
DECLARE counter bigint;
DECLARE xyz CURSOR FOR SELECT * from public.ipv42location AS a
   where a.country_region_city_id is null LIMIT 5 ;
DECLARE xyz_row RECORD;
DECLARE temprow RECORD;
BEGIN
counter := 1;
country_temp := '';
region_temp := '';
city_temp := '';
FOR xyz_row IN xyz
    LOOP
	country_temp := xyz_row.country_name ;
	region_temp := xyz_row.region ;
	city_temp := xyz_row.city ;
	IF xyz_row.country_region_city_id IS NULL THEN
		UPDATE public.ipv42location  
		SET country_region_city_id = counter
			WHERE country_name = country_temp 
			AND region = region_temp
			AND city = city_temp
			AND country_region_city_id IS NOT NULL;
		counter := counter + CAST('1' AS bigint);
    END IF;
	RETURN NEXT xyz_row.country_region_city_id;			
END LOOP;
END;
$BODY$ LANGUAGE plpgsql; 

select * from populate_country_region_city_id_ipv4();
select Count(*) from public.ipv42location as a where a.country_region_city_id is not null;
select country_region_city_id, country_name, region, city from public.ipv42location as a 
     where a.country_region_city_id is not null; 
select * from public.ipv42loc ORDER BY ipv4_from ASC LIMIT 100;
select Count(*) from public.ip2location ;
select * from ip2loc_sm_tab;
