-- FUNCTION: public.find_ip_location_uid_fctn()

-- DROP FUNCTION public.find_ip_location_uid_fctn();

CREATE OR REPLACE FUNCTION public.find_ip_location_uid_fctn()
    RETURNS trigger
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE loc_uid_temp bigint;
BEGIN
    SELECT *
    FROM public.find_location_uid_helper(NEW.ip)
    INTO loc_uid_temp;
	--
	NEW.location_uid := loc_uid_temp;
	--
RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.find_ip_location_uid_fctn()
    OWNER TO silpgadmin;
