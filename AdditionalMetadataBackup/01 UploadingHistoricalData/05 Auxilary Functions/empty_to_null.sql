-- FUNCTION: public.empty_to_null(input_text text)

-- DROP FUNCTION public.empty_to_null(input_text text);

CREATE OR REPLACE FUNCTION public.empty_to_null(input_text text)
RETURNS text AS $BODY$  
BEGIN
	IF input_text ='' or input_text IS NULL THEN 
	   input_text := NULL;
	END IF;
	RETURN input_text;			
END;
$BODY$
LANGUAGE plpgsql;

ALTER FUNCTION public.empty_to_null(input_text text)
    OWNER TO silpgadmin;
	
select public.empty_to_null(a.language2_iso639_code) from bloomreadertest.mpdata_change_page_layout AS a
Where a.city = 'Port Vila'; 
select * from bloomreadertest.mpdata_change_page_layout