-- DROP FUNCTION public.insert_ip_country_helper();

-- This is more-or-less the same as the trigger functions insert_ip-country_bloom_fctn() and public.insert_context_ip_country_bloom_fctn()
-- The only difference between those two 0-arg trigger functions was which Column Name they read from.
-- So the 99% identical part was extracted out and turned it into this 1-arg function
-- I kept the trigger functions the same though (didn't combine them into a single trigger function that requires an argument), because:
-- 1) Mainly so that we don't have to update a bunch of tables' triggers.
-- 2) A minor reason is that passing arguments to trigger functions is more annoying than to a normal function.
CREATE OR REPLACE FUNCTION public.insert_ip_country_helper(ip_address character varying) RETURNS void
    LANGUAGE plpgsql VOLATILE
    AS $$
DECLARE
    hold_region varchar(100);
    hold_city varchar(100);
    country_name_temp varchar(64);
    country_code_temp char(3);
    loc_uid_temp bigint;
    counter bigint;
BEGIN
	SELECT MAX(c.loc_uid) FROM public.countryregioncitylu AS c INTO counter;
	country_code_temp :=NULL;
	country_name_temp :=NULL;
	hold_region :=NULL;
	hold_city :=NULL;

    SELECT b.country_code, b.country_name, b.region, b.city FROM public.ipv42location AS b 
    WHERE (SELECT public.ip2ipv4(ip_address))
    BETWEEN b.ipv4_from and b.ipv4_to 
    INTO country_code_temp, country_name_temp, hold_region, hold_city ;

    INSERT INTO public.ip2loc_sm_tab as s  
        (context_ip, country_code, country_name)
    VALUES
        (public.ip2ipv4(ip_address), country_code_temp, country_name_temp)
    ON CONFLICT ON CONSTRAINT ip2loc_sm_tab_db1_pkey DO NOTHING;

	loc_uid_temp := NULL;
	SELECT i.loc_uid from public.countryregioncitylu AS i
		where i.country_code = country_code_temp
		AND i.region = hold_region
		AND i.city = hold_city
		INTO loc_uid_temp;
	IF loc_uid_temp IS NULL THEN
        counter := counter + CAST('1' AS bigint);
		loc_uid_temp := counter ;
		INSERT INTO  public.countryregioncitylu as p  
		( loc_uid, country_code, country_name, region, city  )  
		VALUES
		( loc_uid_temp, country_code_temp, country_name_temp, hold_region, hold_city ) ;
	END IF;
END;
$$;

ALTER FUNCTION public.insert_ip_country_helper(ip_address character varying) OWNER TO silpgadmin;

