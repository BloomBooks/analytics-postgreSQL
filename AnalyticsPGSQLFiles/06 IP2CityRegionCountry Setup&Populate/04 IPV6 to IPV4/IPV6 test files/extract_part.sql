-- FUNCTION: public.extract(character varying)

-- DROP FUNCTION public.extract(ip character varying,delimiter char(1),idx integer);

CREATE OR REPLACE FUNCTION public.extract(
	ip character varying,
	delimiter char(1),
	idx integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'

    COST 100
    IMMUTABLE 
AS $BODY$

DECLARE
  ipint int8;
  iptemp text;
  string character varying;
BEGIN
RETURN
	CASE idx
		WHEN 0 THEN ip
	ELSE
		(
		SELECT string
		FROM
		(
			SELECT SUBSTRING(ip from n for strpos( delimiter, ip + delimiter, n ) - n ), n + 1 - LENGTH(REPLACE(LEFT(ip, n), delimiter, ''))
			WHERE SUBSTRING(delimiter + ip from n for 1) = delimiter
			AND n < LENGTH(ip) + 1) AS T(string, idx)
		)
	END;
END;

$BODY$;

ALTER FUNCTION public.extract(character varying,char(1),integer)
    OWNER TO silpgadmin;	
	