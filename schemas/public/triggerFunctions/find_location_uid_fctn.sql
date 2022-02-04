-- FUNCTION: public.find_location_uid_fctn()

-- DROP FUNCTION public.find_location_uid_fctn();

CREATE OR REPLACE FUNCTION public.find_location_uid_fctn()
    RETURNS trigger
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE ip_address_temp text;
DECLARE hold_region varchar(100);
DECLARE hold_city varchar(100);
DECLARE country_name_temp varchar(64);
DECLARE country_code_temp char(3);
DECLARE loc_uid_temp bigint;
DECLARE counter bigint;
BEGIN
	counter := NULL;
	SELECT MAX(c.loc_uid) FROM public.countryregioncitylu AS c INTO counter;
	ip_address_temp := NEW.context_ip;
	country_code_temp :=NULL;
	country_name_temp :=NULL;
	hold_region :=NULL;
	hold_city :=NULL;
	SELECT b.country_code, b.country_name, b.region, b.city FROM public.ipv42location AS b
		WHERE (SELECT public.ip2ipv4(ip_address_temp))
		BETWEEN b.ipv4_from and b.ipv4_to
		INTO country_code_temp, country_name_temp, hold_region, hold_city ;
	IF country_code_temp ='-' or public.empty_to_null(country_code_temp) IS NULL THEN
		country_code_temp := '-';
	END IF;
	IF country_name_temp ='-' or public.empty_to_null(country_name_temp) IS NULL THEN
		country_name_temp := '-';
	END IF;
	IF hold_region ='-' or public.empty_to_null(hold_region) IS NULL THEN
		hold_region := '-';
	END IF;
	IF hold_city ='-' or public.empty_to_null(hold_city) IS NULL THEN
		hold_city := '-';
	END IF;
	loc_uid_temp := NULL;
	SELECT i.loc_uid from public.countryregioncitylu AS i
		WHERE i.country_code = country_code_temp
		AND i.region = hold_region
		AND i.city = hold_city
		INTO loc_uid_temp;
	IF loc_uid_temp IS NULL THEN
		counter := counter + CAST('1' AS bigint);
		loc_uid_temp := counter ;
		INSERT INTO  public.countryregioncitylu as p
		( loc_uid, country_code, country_name, region, city  )
		VALUES
		( loc_uid_temp, country_code_temp, country_name_temp, hold_region, hold_city )
		ON CONFLICT ON CONSTRAINT countryregioncitylu_db1_pkey DO NOTHING;
	END IF;
	--
	NEW.location_uid := loc_uid_temp;
	--
RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.find_location_uid_fctn()
    OWNER TO silpgadmin;
