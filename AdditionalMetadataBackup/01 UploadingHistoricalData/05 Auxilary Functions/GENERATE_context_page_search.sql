--DROP FUNCTION GENERATE_context_page_search();

CREATE OR REPLACE FUNCTION GENERATE_context_page_search()
RETURNS SETOF varchar AS $BODY$
DECLARE err_constraint varchar(100);
DECLARE temp_url text;
DECLARE search_part text;
DECLARE xyz CURSOR FOR SELECT DISTINCT(a.source_for_context_page_search)
		FROM bloomreadertest.mpdata_preview AS a
	   	WHERE POSITION('?' IN a.source_for_context_page_search) > 0;
DECLARE xyz_row RECORD;
BEGIN
   	UPDATE bloomreadertest.mpdata_preview
	SET  source_for_context_page_search = NULL
	WHERE POSITION('?' IN source_for_context_page_search) = 0;

temp_url := NULL;
search_part := NULL;
FOR xyz_row IN xyz
    LOOP
	temp_url := xyz_row.source_for_context_page_search;

   	UPDATE bloomreadertest.mpdata_preview
	SET  source_for_context_page_search = 
				SUBSTRING(source_for_context_page_search FROM 
				POSITION('?' IN source_for_context_page_search) )
	WHERE source_for_context_page_search = temp_url;
	temp_url := NULL;
	RETURN NEXT xyz_row.source_for_context_page_search;			
END LOOP;

EXCEPTION
   WHEN SQLSTATE '23000' THEN  -- Class 23 ? Integrity Constraint Violation
      GET STACKED DIAGNOSTICS err_constraint = CONSTRAINT_NAME;
      -- do something with it, for instance:
      RAISE NOTICE '%', err_constraint;
      RAISE;  -- raise original error
END;
$BODY$ LANGUAGE plpgsql;
	
--SELECT * FROM GENERATE_context_page_search();

SELECT DISTINCT(a.user_id) from bloomreadertest.mpdata_preview AS a
	   ORDER BY a.user_id;

SELECT DISTINCT(a.source_for_context_page_search)
		FROM bloomreadertest.mpdata_preview AS a
	   WHERE POSITION('?' IN a.source_for_context_page_search) >0 ;
	   
	   
SELECT DISTINCT ON (a.context_page_initial_referrer, a.context_page_referrer)
					a.context_page_initial_referrer, a.context_page_referrer
					FROM bloomreadertest.mpdata_book_search AS a
	   WHERE a.context_page_initial_referrer IS NOT NULL 
	   AND a.context_page_referrer IS NOT NULL;
SELECT SUBSTRING(a.source_for_context_page_search FROM 
				 POSITION('?' IN a.source_for_context_page_search) )
	FROM bloomreadertest.mpdata_book_search AS a
	WHERE POSITION('?' IN a.source_for_context_page_search) >0 ;
Select a.source_for_context_page_search FROM bloomreadertest.mpdata_book_search AS a
   WHERE a.source_for_context_page_search IS NOT NULL;
SELECT a.context_page_search FROM bloomlibrary_org.book_search AS a
   WHERE a.context_page_search IS NOT NULL;