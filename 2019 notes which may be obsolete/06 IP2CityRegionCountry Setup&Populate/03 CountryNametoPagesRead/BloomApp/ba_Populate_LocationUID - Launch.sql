--DROP FUNCTION populate_location_uid_function();

CREATE OR REPLACE FUNCTION populate_location_uid_function()
RETURNS SETOF varchar AS $BODY$
DECLARE ip_address_temp text;
DECLARE hold_region varchar(100);
DECLARE hold_city varchar(100);
DECLARE country_name_temp varchar(64);
DECLARE country_code_temp char(3);
DECLARE loc_uid_temp bigint;
DECLARE counter bigint;
DECLARE xyz CURSOR FOR SELECT * from bloomapp.launch AS a
	WHERE a.location_uid IS NULL;
DECLARE xyz_row RECORD;
DECLARE temprow RECORD;
BEGIN

FOR xyz_row IN xyz
    LOOP
	counter := NULL;
	SELECT MAX(c.loc_uid) FROM public.countryregioncitylu AS c INTO counter;
	ip_address_temp := xyz_row.ip;
	country_code_temp :=NULL;
	country_name_temp :=NULL;
	hold_region :=NULL;
	hold_city :=NULL; 
	SELECT b.country_code, b.country_name, b.region, b.city FROM public.ipv42location AS b 
           WHERE (SELECT public.ip2ipv4(ip_address_temp))
           BETWEEN b.ipv4_from and b.ipv4_to 
		   INTO country_code_temp, country_name_temp, hold_region, hold_city ;
	loc_uid_temp := NULL;
	SELECT i.loc_uid from public.countryregioncitylu AS i
		where i.country_code = country_code_temp
		AND i.region = hold_region
		AND i.city = hold_city
		INTO loc_uid_temp;
	
	IF loc_uid_temp IS NULL THEN
        counter := counter + CAST('1' AS bigint);
		loc_uid_temp := counter ;
		INSERT INTO  public.countryregioncitylu as p  
		( loc_uid, country_code, country_name, region, city  )  
		VALUES
		( loc_uid_temp, country_code_temp, country_name_temp, hold_region, hold_city ) ;
	END IF;
	--
	UPDATE bloomapp.launch  
	SET location_uid = loc_uid_temp
	WHERE id = xyz_row.id;
	--
	RETURN NEXT xyz_row.id;		
END LOOP;

END;
$BODY$ LANGUAGE plpgsql;

SELECT * FROM populate_location_uid_function();
commit;

select * from public.ip2location;
select * from public.ip2loc_sm_tab;
select * from bloomreader.questions_correct where populate_country is not null;
select * from bloomreader.questions_correct;

select * FROM bloomreader.questions_correct AS a WHERE a.id ='010a3627-2357-43be-b383-6ce518961eae'; 


SELECT b.populate_country FROM public.ip2location AS b
   WHERE (SELECT ip2int(a.context_ip) FROM bloomreader.questions_correct AS a 
                 WHERE a.id = '010a3627-2357-43be-b383-6ce518961eae') BETWEEN b.ip_from and b.ip_to;
		
UPDATE bloomreader.questions_correct AS a 
  SET populate_country = 
  (SELECT b.populate_country FROM public.ip2location AS b
   WHERE (SELECT ip2int(a.context_ip) FROM bloomreader.questions_correct AS a 
          WHERE a.id = '010a3627-2357-43be-b383-6ce518961eae') 
          BETWEEN b.ip_from and b.ip_to)
   WHERE a.id = '010a3627-2357-43be-b383-6ce518961eae';
   
select * from bloomreader.questions_correct where populate_country is not null;