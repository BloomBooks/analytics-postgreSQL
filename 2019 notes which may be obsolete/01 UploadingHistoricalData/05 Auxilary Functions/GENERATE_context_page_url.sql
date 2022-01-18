--DROP FUNCTION GENERATE_context_page_url();

CREATE OR REPLACE FUNCTION GENERATE_context_page_url()
RETURNS SETOF varchar AS $BODY$
DECLARE err_constraint varchar(100);
DECLARE url text;
DECLARE search_part text;
DECLARE xyz CURSOR FOR SELECT DISTINCT(a.context_page_url)
		FROM bloomreadertest.mpdata_log_out AS a
	   	WHERE  a.context_page_url IS NOT NULL;
DECLARE xyz_row RECORD;
BEGIN
   	UPDATE bloomreadertest.mpdata_log_out
	SET  source_for_context_page_search = NULL
	WHERE context_page_url IS NULL;

url := NULL;
search_part := NULL;
FOR xyz_row IN xyz
    LOOP
	url := xyz_row.context_page_url;

   	UPDATE bloomreadertest.mpdata_log_out
	SET  source_for_context_page_search = url
	WHERE context_page_url = url;
	url := NULL;
	RETURN NEXT xyz_row.context_page_url;			
END LOOP;

EXCEPTION
   WHEN SQLSTATE '23000' THEN  -- Class 23 ? Integrity Constraint Violation
      GET STACKED DIAGNOSTICS err_constraint = CONSTRAINT_NAME;
      -- do something with it, for instance:
      RAISE NOTICE '%', err_constraint;
      RAISE;  -- raise original error
END;
$BODY$ LANGUAGE plpgsql;
	
--SELECT * FROM GENERATE_context_page_url();

SELECT DISTINCT(a.user_id) from bloomreadertest.mpdata_book_search AS a
	   ORDER BY a.user_id;

SELECT DISTINCT(a.context_page_url)
		FROM bloomreadertest.mpdata_log_out AS a
	   	WHERE  a.context_page_url IS NOT NULL;

SELECT DISTINCT(a.source_for_context_page_search)
		FROM bloomreadertest.mpdata_book_search AS a
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