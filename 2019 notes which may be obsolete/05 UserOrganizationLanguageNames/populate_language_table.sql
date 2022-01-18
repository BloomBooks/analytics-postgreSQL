-- FUNCTION: public.populate_language_function()

-- DROP FUNCTION public.populate_language_function();

CREATE OR REPLACE FUNCTION public.populate_language_function(
	)
    RETURNS SETOF character varying 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
AS $BODY$

DECLARE language_id_temp varchar(20);
DECLARE language_temp varchar(50);
DECLARE xyz CURSOR FOR SELECT * from bloomapp.users AS a;
DECLARE xyz_row RECORD;
DECLARE temprow RECORD;
BEGIN

FOR xyz_row IN xyz
    LOOP
	language_id_temp :='';
	language_temp :='';
 	SELECT 
	CASE
       WHEN length(xyz_row.uilanguage) = 2 then (SELECT c.clname FROM public.languagecodes AS c 
							WHERE xyz_row.uilanguage=c.langid2)
	   WHEN length(xyz_row.uilanguage) > 3 then  (SELECT e.clname FROM public.languagecodes AS e 
						WHERE SUBSTRING(xyz_row.uilanguage from 1 for 2)=e.langid2)
	   ELSE /* length(xyz_row.uilanguage) = 3 then */ 
		(SELECT d.clname FROM public.languagecodes AS d WHERE xyz_row.uilanguage=d.langid)                     
	END AS UILanguage
	INTO language_temp;
    IF (xyz_row.uilanguage IS NOT NULL) THEN
   		INSERT INTO  public.used_languages as s  
		( language_id, language_name)
		VALUES
		(xyz_row.uilanguage, language_temp)
   		  ON CONFLICT ON CONSTRAINT used_languages_pkey DO NOTHING;
    END IF;
	RETURN NEXT language_temp;		
END LOOP;
END;
$BODY$;

ALTER FUNCTION public.populate_language_function()
    OWNER TO silpgadmin;
	
SELECT * FROM public.populate_language_function();

select * from public.used_languages;

select uilanguage from bloomapp.users where length(uilanguage)> 6;