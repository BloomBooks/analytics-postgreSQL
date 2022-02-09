-- FUNCTION: public.insert_context_ip_country_bloom_fctn()

-- DROP FUNCTION public.insert_context_ip_country_bloom_fctn();

CREATE OR REPLACE FUNCTION public.insert_context_ip_country_bloom_fctn()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    VOLATILE
-- NOTE: In the old database, Postgres says that this is "NOT LEAKPROOF".#
-- When I try to specify "NOT LEAKPROOF" again, it gives an error about leakproof. Apparently, FlexServer does not support leakproof yet.
-- Support is expected in Feb 2022, although here we are in Feb 2022...
-- That's why the below line is commented out.
--    NOT LEAKPROOF
AS $$
DECLARE
BEGIN
    PERFORM public.insert_ip_country_helper(NEW.context_ip);
RETURN NEW;
END;

$$;

ALTER FUNCTION public.insert_context_ip_country_bloom_fctn() OWNER TO silpgadmin;