-- FUNCTION: public.insert_ip_country_row_fctn()

-- DROP FUNCTION public.insert_ip_country_row_fctn();

CREATE FUNCTION public.insert_ip_country_row_fctn()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF 
AS $BODY$

DECLARE ip_address_temp text;
DECLARE country_name_temp varchar(50);
DECLARE country_code_temp char(3);
BEGIN
	ip_address_temp := NEW.context_ip;
	country_code_temp :='';
	country_name_temp :=''; 
SELECT b.country_code, b.country_name FROM public.ip2location AS b 
           WHERE (SELECT public.ip2int(NEW.context_ip))
           BETWEEN b.ip_from and b.ip_to into country_code_temp, country_name_temp ;
INSERT INTO public.ip2loc_sm_tab as s  
	(context_ip, country_code, country_name)
	VALUES
	(public.ip2int(ip_address_temp), country_code_temp, country_name_temp)
     ON CONFLICT ON CONSTRAINT ip2loc_sm_tab_db1_pkey DO NOTHING;
	
RETURN NEW;
END;

$BODY$;

ALTER FUNCTION public.insert_ip_country_row_fctn()
    OWNER TO silpgadmin;