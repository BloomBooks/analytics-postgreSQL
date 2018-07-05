-- FUNCTION: public.populate_region_city_for_ip2loc_sm_tab()

-- DROP FUNCTION public.populate_region_city_for_ip2loc_sm_tab();

CREATE OR REPLACE FUNCTION public.populate_region_city_for_ip2loc_sm_tab(
	)
    RETURNS SETOF character varying 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
AS $BODY$

DECLARE ip_address_temp bigint;
DECLARE region_temp varchar(100);
DECLARE city_temp varchar(100);
DECLARE xyz CURSOR FOR SELECT * from public.ip2loc_sm_tab AS a;
DECLARE xyz_row RECORD;
BEGIN

FOR xyz_row IN xyz
    LOOP
	SELECT b.region, b.city from public.ipv42location AS b
		WHERE xyz_row.context_ip BETWEEN b.ipv4_from AND b.ipv4_to
		INTO  region_temp, city_temp;

	UPDATE public.ip2loc_sm_tab
		SET region = region_temp,
			city = city_temp 
		WHERE context_ip = xyz_row.context_ip;

	region_temp := '-';
	city_temp := '-';

	RETURN NEXT xyz_row.context_ip;		
END LOOP;

END;
$BODY$;

ALTER FUNCTION public.populate_region_city_for_ip2loc_sm_tab()
    OWNER TO silpgadmin;

SELECT * from public.populate_region_city_for_ip2loc_sm_tab();
select * from public.ip2loc_sm_tab;