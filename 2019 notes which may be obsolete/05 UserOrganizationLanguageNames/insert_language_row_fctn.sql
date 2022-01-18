-- FUNCTION: public.insert_language_row_fctn()

-- DROP FUNCTION public.insert_language_row_fctn();

CREATE OR REPLACE FUNCTION public.insert_language_row_fctn()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF 
AS $BODY$

DECLARE lang_code_temp varchar(20);
DECLARE lang_name_temp varchar(50);
BEGIN
	lang_code_temp := NEW.uilanguage;
	lang_name_temp :='';
	SELECT 
	CASE
        WHEN length(lang_code_temp) = 2 then (SELECT c.clname FROM public.languagecodes AS c 
							WHERE lang_code_temp=c.langid2)
	   WHEN length(lang_code_temp) > 3 then  (SELECT e.clname FROM public.languagecodes AS e 
						WHERE SUBSTRING(lang_code_temp from 1 for 2)=e.langid2)
	   ELSE /* length(lang_code_temp) = 3 then */ 
		(SELECT d.clname FROM public.languagecodes AS d WHERE lang_code_temp=d.langid)
	END AS UILanguage
	INTO lang_name_temp;
	
IF lang_code_temp IS NOT NULL THEN
	INSERT INTO public.used_languages as s  
	(language_id, language_name)
	VALUES
	(lang_code_temp, lang_name_temp)
     ON CONFLICT ON CONSTRAINT used_languages_pkey DO NOTHING;
END IF;

RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.insert_language_row_fctn()
    OWNER TO silpgadmin;
	
GRANT ALL ON FUNCTION public.insert_language_row_fctn() TO segment;