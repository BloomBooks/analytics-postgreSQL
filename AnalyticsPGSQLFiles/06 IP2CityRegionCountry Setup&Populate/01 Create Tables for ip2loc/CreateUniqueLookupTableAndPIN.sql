--DROP FUNCTION createuniquelookuptable_and_pin();

CREATE OR REPLACE FUNCTION createuniquelookuptable_and_pin()
RETURNS SETOF varchar AS $BODY$
DECLARE ip_from decimal (39,0);
DECLARE ip_to decimal (39,0);
DECLARE err_constraint varchar(100);
DECLARE xyz CURSOR FOR SELECT * from public.ipv62loc AS a ;
DECLARE xyz_row RECORD;
DECLARE temprow RECORD;
BEGIN
ip_from := 0;
ip_to := 0;
FOR xyz_row IN xyz
    LOOP
	SELECT CAST(xyz_row.ipv6_from AS decimal (39,0)) INTO ip_from;
	SELECT CAST(xyz_row.ipv6_to AS decimal (39,0)) INTO ip_to;
   	INSERT INTO  public.ipv62location as s  
	( ipv6_from, ipv6_to, country_code, country_name, region, city )
	VALUES
	( ip_from, ip_to, xyz_row.country_code, xyz_row.country_name, xyz_row.region, xyz_row.city ) 
    ON CONFLICT ON CONSTRAINT ipv62location_db1_pkey DO NOTHING;
	RETURN NEXT ip_from;			
END LOOP;
END;
$BODY$ LANGUAGE plpgsql; 

select * from createuniquelookuptable_and_pin();
select Count(*) from public.ipv62loc;
select Count(*) from public.ipv62location;
select * from public.ipv62loc ORDER BY ipv6_from DESC LIMIT 100;
select * from public.ipv62location ORDER BY ipv6_from ASC LIMIT 100;