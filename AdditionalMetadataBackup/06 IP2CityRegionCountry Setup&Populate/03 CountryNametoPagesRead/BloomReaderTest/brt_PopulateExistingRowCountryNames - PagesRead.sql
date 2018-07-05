DROP FUNCTION country_name_function();
---BEGIN;
---SAVEPOINT sp1;
CREATE OR REPLACE FUNCTION country_name_function()
RETURNS SETOF varchar AS $BODY$
DECLARE country_temp varchar(50);
DECLARE xyz CURSOR FOR SELECT * from bloomreadertest.pages_read AS a;
DECLARE xyz_row RECORD;
DECLARE temprow RECORD;
BEGIN

FOR xyz_row IN xyz
    LOOP
	country_temp :='';
	SELECT b.country_name FROM public.ip2location AS b 
           WHERE (SELECT public.ip2int(d.context_ip) FROM bloomreadertest.pages_read AS d 
               	  WHERE d.id = xyz_row.id ) 
           BETWEEN b.ip_from and b.ip_to into country_temp;
	
   	UPDATE bloomreadertest.pages_read  SET country_name = country_temp
               WHERE id = xyz_row.id;

	RETURN NEXT xyz_row.id;		
END LOOP;

END;
$BODY$ LANGUAGE plpgsql;


---ROLLBACK TO sp1;
SELECT * FROM country_name_function();
commit;


select * from bloomreadertest.pages_read where country_name is not null;
select * from bloomreadertest.pages_read;

select * FROM bloomreadertest.pages_read AS a WHERE a.id ='010a3627-2357-43be-b383-6ce518961eae'; 


SELECT b.country_name FROM public.ip2location AS b
   WHERE (SELECT ip2int(a.context_ip) FROM bloomreadertest.pages_read AS a 
                 WHERE a.id = '010a3627-2357-43be-b383-6ce518961eae') BETWEEN b.ip_from and b.ip_to;
		
UPDATE bloomreadertest.pages_read AS a 
  SET country_name = 
  (SELECT b.country_name FROM public.ip2location AS b
   WHERE (SELECT ip2int(a.context_ip) FROM bloomreadertest.pages_read AS a 
          WHERE a.id = '010a3627-2357-43be-b383-6ce518961eae') 
          BETWEEN b.ip_from and b.ip_to)
   WHERE a.id = '010a3627-2357-43be-b383-6ce518961eae';
   
select * from bloomreadertest.pages_read where country_name is not null;