-- FUNCTION: public.find_location_uid_helper()

-- DROP FUNCTION public.find_location_uid_helper();

-- This is extracted out from the shared code of find_location_uid_fctn and find_closest_city_and_location_uid_fctn
-- It takes the IP address, maps it to a location, then
-- finds it in the countryregioncitylu table (or adds it if necessary),
-- and returns the loc_uid of the row in the countryregioncitylu table.
CREATE OR REPLACE FUNCTION public.find_location_uid_helper(ip_address character varying)
    RETURNS bigint
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    ip_address_temp text;
    hold_region varchar(100);
    hold_city varchar(100);
    country_name_temp varchar(64);
    country_code_temp char(3);
    loc_uid_temp bigint;
    counter bigint;
BEGIN
	counter := NULL;
	SELECT MAX(c.loc_uid) FROM public.countryregioncitylu AS c INTO counter;
	ip_address_temp := ip_address;
	country_code_temp :=NULL;
	country_name_temp :=NULL;
	hold_region :=NULL;
	hold_city :=NULL;

    -- New algorithm to map from IP address (either IPv4 or IPv6) to location
    -- old (used ip2ipv4() function, but that doesn't handle most IPv6 addreses correctly)
	SELECT country_code, country_name, region, city
	FROM public.ip_to_location(ip_address_temp)
	INTO country_code_temp, country_name_temp, hold_region, hold_city;

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
	RETURN loc_uid_temp;
END;
$BODY$;

ALTER FUNCTION public.find_location_uid_fctn()
    OWNER TO silpgadmin;
