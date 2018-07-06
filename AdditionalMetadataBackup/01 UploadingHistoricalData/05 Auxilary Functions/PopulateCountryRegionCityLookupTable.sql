--DROP FUNCTION Populate_CountryRegionCityLU();

CREATE OR REPLACE FUNCTION Populate_CountryRegionCityLU()
RETURNS SETOF varchar AS $BODY$
DECLARE xyz CURSOR FOR SELECT distinct (a.country_code, a.region, a.city), 
			a.loc_uid, a.country_code, a.country_name, a.region, a.city
   			FROM public.ip2loc_sm_tab AS a
   			ORDER BY a.loc_uid ASC, a.country_name ASC, a.region ASC, a.city ASC;
DECLARE xyz_row RECORD;
BEGIN
FOR xyz_row IN xyz
    LOOP
   	INSERT INTO  public.countryregioncitylu as s  
	( loc_uid, country_code, country_name, region, city) 
	VALUES
	( xyz_row.loc_uid, xyz_row.country_code, xyz_row.country_name, xyz_row.region, xyz_row.city) 
    ON CONFLICT ON CONSTRAINT countryregioncitylu_db1_pkey DO NOTHING;
	RETURN NEXT xyz_row.loc_uid;			
END LOOP;

END;
$BODY$ LANGUAGE plpgsql;

--select * from Populate_CountryRegionCityLU();
SELECT distinct (a.country_code, a.region, a.city), 
			a.loc_uid, a.country_code, a.country_name, a.region, a.city
   			FROM public.ip2loc_sm_tab AS a
   			ORDER BY a.loc_uid ASC, a.country_name ASC, a.region ASC, a.city ASC;
select Count(*) from public.countryregioncitylu;
select * from public.countryregioncitylu
   WHERE country_code = '';
select * from bloomapp.launch AS a 
   WHERE a.location_uid is null;
   
SELECT b.country_code, b.country_name, b.region, b.city FROM public.ipv42location AS b 
           WHERE (SELECT public.ip2ipv4('116.66.198.54'))
           BETWEEN b.ipv4_from and b.ipv4_to 




