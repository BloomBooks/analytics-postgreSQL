
CREATE OR REPLACE FUNCTION public.ip_to_location(
        ip_address character varying,
        OUT country_code character(2),
        OUT country_name character varying(64),
        OUT region character varying(100),
        OUT city character varying(100)
    )
    RETURNS RECORD
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
BEGIN
    --------
    -- Given an IP address, returns the location from either ipv42location (for IPV4 addresses) or ipv62location (for IPv6 addresses)
    --------


    IF public.is_ipv6(ip_address) THEN
        SELECT a.country_code, a.country_name, a.region, a.city
        FROM public.ipv62location AS a
        WHERE public.ip_to_ipv6number(ip_address) BETWEEN ipv6_from and ipv6_to
        INTO country_code, country_name, region, city;
    ELSE
        SELECT a.country_code, a.country_name, a.region, a.city
        FROM public.ipv42location AS a
        WHERE public.ip_to_ipv4number(ip_address) BETWEEN ipv4_from and ipv4_to
        INTO country_code, country_name, region, city;
    END IF;
END;
$$;

ALTER FUNCTION public.ip_to_location(ip_address character varying) OWNER TO silpgadmin;


-- Unit test for ip_to_location
-- Make sure all columns return true.
SELECT
    (public.ip_to_location('2800:98:1010:ef84:d38a:d0a7:3724:570a')).city='Guatemala City' AS pass1,
    (public.ip_to_location('152.0.0.16')).city='Santo Domingo' AS pass2,
    (public.ip_to_location('garbage input')).city='-' AS pass3
FROM public.ipv42location -- any valid table name works
LIMIT 1
;