-- FUNCTION: public.ipv62country_name(cumeric)

-- DROP FUNCTION public.ipv62country_name(numeric);

CREATE OR REPLACE FUNCTION public.ipv62country_name(ip_in
	decimal(39,0))
    RETURNS character varying
    LANGUAGE 'plpgsql'

    COST 100
    IMMUTABLE STRICT
AS $BODY$
DECLARE
  country text;
BEGIN  
 country :='';
SELECT country_name
      FROM public.ipv62location INTO country
      WHERE ip_in BETWEEN ip_from AND ip_to;
return country;
END;	  
$BODY$;

ALTER FUNCTION public.ipv62country_name(decimal(39,0))
    OWNER TO silpgadmin;