-- FUNCTION: public.insert_context_ip_country_bloom_fctn()

-- DROP FUNCTION public.insert_context_ip_country_bloom_fctn();

CREATE FUNCTION public.insert_context_ip_country_bloom_fctn()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$

DECLARE ip_address_temp text;
DECLARE hold_region varchar(100);
DECLARE hold_city varchar(100);
DECLARE country_name_temp varchar(64);
DECLARE country_code_temp char(3);
DECLARE loc_uid_temp bigint;
DECLARE counter bigint;
BEGIN

	SELECT MAX(c.loc_uid) FROM public.countryregioncitylu AS c INTO counter;
	ip_address_temp := NEW.context_ip;
	country_code_temp :=NULL;
	country_name_temp :=NULL;
	hold_region :=NULL;
	hold_city :=NULL;
SELECT b.country_code, b.country_name, b.region, b.city FROM public.ipv42location AS b 
           WHERE (SELECT public.ip2ipv4(NEW.context_ip))
           BETWEEN b.ipv4_from and b.ipv4_to 
		   INTO country_code_temp, country_name_temp, hold_region, hold_city ;
	INSERT INTO public.ip2loc_sm_tab as s  
		(context_ip, country_code, country_name)
	VALUES
		(public.ip2ipv4(ip_address_temp), country_code_temp, country_name_temp)
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
	

RETURN NEW;
END;

$BODY$;

ALTER FUNCTION public.insert_context_ip_country_bloom_fctn()
    OWNER TO silpgadmin;
