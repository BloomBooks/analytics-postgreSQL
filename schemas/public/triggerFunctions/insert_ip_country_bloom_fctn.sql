-- FUNCTION: public.insert_ip_country_bloom_fctn()

-- DROP FUNCTION public.insert_ip_country_bloom_fctn();

CREATE OR REPLACE FUNCTION public.insert_ip_country_bloom_fctn() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN
    PERFORM public.insert_ip_country_helper(NEW.ip);
RETURN NEW;
END;

$$;


ALTER FUNCTION public.insert_ip_country_bloom_fctn() OWNER TO silpgadmin;
