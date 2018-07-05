--DROP FUNCTION country_name_func_br();

CREATE OR REPLACE FUNCTION country_name_func_br()
RETURNS SETOF varchar AS $BODY$
DECLARE country_temp varchar(50);
DECLARE xyz CURSOR FOR SELECT * from bloomreader.pages_read AS a;
DECLARE xyz_row RECORD;
DECLARE temprow RECORD;
BEGIN

FOR xyz_row IN xyz
    LOOP
	country_temp :='';
	SELECT b.country_name FROM public.ip2location AS b 
           WHERE (SELECT ip2int(d.context_ip) FROM bloomreader.pages_read AS d 
               	  WHERE d.id = xyz_row.id ) 
           BETWEEN b.ip_from and b.ip_to into country_temp;
	
   	UPDATE bloomreader.pages_read  SET country_name = country_temp
               WHERE id = xyz_row.id;

	RETURN NEXT xyz_row.id;		
END LOOP;

END;
$BODY$ LANGUAGE plpgsql;


--ROLLBACK TO sp1;
--SELECT * FROM country_name_func_br();

--select * from bloomreader.pages_read where country_name is not null;
--select * from bloomreader.pages_read where country_name is null;