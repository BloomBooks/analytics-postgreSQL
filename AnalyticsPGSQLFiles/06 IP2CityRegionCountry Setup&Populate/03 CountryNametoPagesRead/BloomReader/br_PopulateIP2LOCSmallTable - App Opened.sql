DROP FUNCTION populate_country_function();
--BEGIN;
--SAVEPOINT sp1;
CREATE OR REPLACE FUNCTION populate_country_function()
RETURNS SETOF varchar AS $BODY$
DECLARE ip_address_temp text;
DECLARE country_temp varchar(50);
DECLARE country_code_temp char(3);
DECLARE xyz CURSOR FOR SELECT * from bloomreader.application_opened AS a;
DECLARE xyz_row RECORD;
DECLARE temprow RECORD;
BEGIN

FOR xyz_row IN xyz
    LOOP
	ip_address_temp := xyz_row.context_ip;
	country_code_temp :='';
	country_temp :=''; 
	SELECT b.country_code, b.country_name FROM public.ip2location AS b 
           WHERE (SELECT public.ip2int(d.context_ip) FROM bloomreader.application_opened AS d 
               	  WHERE d.id = xyz_row.id ) 
           BETWEEN b.ip_from and b.ip_to into country_code_temp, country_temp ;
	
   	INSERT INTO  public.ip2loc_sm_tab as s  
	( context_ip, country_code, country_name)
	VALUES
	(public.ip2int(ip_address_temp), country_code_temp, country_temp)
     ON CONFLICT ON CONSTRAINT ip2loc_sm_tab_db1_pkey DO NOTHING;

	RETURN NEXT xyz_row.id;		
END LOOP;

END;
$BODY$ LANGUAGE plpgsql;


--ROLLBACK TO sp1;
SELECT * FROM populate_country_function();
commit;

select * from public.ip2location;
select * from public.ip2loc_sm_tab;
select * from bloomreader.application_opened where populate_country is not null;
select * from bloomreader.application_opened;

select * FROM bloomreader.application_opened AS a WHERE a.id ='010a3627-2357-43be-b383-6ce518961eae'; 


SELECT b.populate_country FROM public.ip2location AS b
   WHERE (SELECT ip2int(a.context_ip) FROM bloomreader.application_opened AS a 
                 WHERE a.id = '010a3627-2357-43be-b383-6ce518961eae') BETWEEN b.ip_from and b.ip_to;
		
UPDATE bloomreader.application_opened AS a 
  SET populate_country = 
  (SELECT b.populate_country FROM public.ip2location AS b
   WHERE (SELECT ip2int(a.context_ip) FROM bloomreader.application_opened AS a 
          WHERE a.id = '010a3627-2357-43be-b383-6ce518961eae') 
          BETWEEN b.ip_from and b.ip_to)
   WHERE a.id = '010a3627-2357-43be-b383-6ce518961eae';
   
select * from bloomreader.application_opened where populate_country is not null;