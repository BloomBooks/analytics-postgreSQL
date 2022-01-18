--DROP FUNCTION find_country_fctn() CASCADE;
--BEGIN;
--SAVEPOINT sp1;
CREATE OR REPLACE FUNCTION find_country_fctn()
RETURNS trigger AS $find_country_fctn$
DECLARE country_temp varchar(50);
BEGIN
country_temp :='';
SELECT b.country_name FROM public.ip2location AS b 
           WHERE (SELECT public.ip2int(NEW.context_ip))
           BETWEEN b.ip_from and b.ip_to into country_temp;
UPDATE bloomreadertest.pages_read  
	SET country_name = country_temp
	WHERE id = NEW.id;
NEW.country_name := country_temp;	
RETURN NEW;
END;
$find_country_fctn$ LANGUAGE plpgsql;

--ROLLBACK TO sp1;






