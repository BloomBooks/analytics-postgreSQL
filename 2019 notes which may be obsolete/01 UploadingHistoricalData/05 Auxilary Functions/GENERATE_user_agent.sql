--DROP FUNCTION GENERATE_user_agent;

CREATE OR REPLACE FUNCTION GENERATE_user_agent()
RETURNS SETOF varchar AS $BODY$
DECLARE time_max_for_historical_data timestamp;
DECLARE new_id varchar(1024);
DECLARE err_constraint varchar(100);
DECLARE user_agent_temp text;
DECLARE xyz CURSOR FOR SELECT DISTINCT ON (a.browser, a.browser_version, a.osversion)
		a.browser, a.browser_version, a.osversion
		from bloomreadertest.mpdata_preview AS a
		WHERE a.browser IS NOT NULL;
DECLARE xyz_row RECORD;
BEGIN
user_agent_temp := NULL;
FOR xyz_row IN xyz
    LOOP
	user_agent_temp := NULL;
	IF xyz_row.browser_version IS NULL and xyz_row.osversion IS NULL THEN
		user_agent_temp := xyz_row.browser;
	   	UPDATE bloomreadertest.mpdata_preview
		SET  context_user_agent = user_agent_temp
		WHERE browser = xyz_row.browser
			AND (browser_version IS NULL) 
			AND (osversion IS NULL);
			user_agent_temp := NULL;
	ELSIF (xyz_row.browser_version IS NULL) THEN
		SELECT xyz_row.browser||' ('||xyz_row.osversion||')' INTO user_agent_temp;
	   	UPDATE bloomreadertest.mpdata_preview
		SET  context_user_agent = user_agent_temp
		WHERE browser =  xyz_row.browser 
			AND osversion =  xyz_row.osversion 
			AND (browser_version IS NULL);
			user_agent_temp := NULL;	
	ELSIF (xyz_row.osversion IS NULL) THEN		
		SELECT xyz_row.browser||'/'||xyz_row.browser_version INTO user_agent_temp;
		UPDATE bloomreadertest.mpdata_preview
		SET  context_user_agent = user_agent_temp
		WHERE browser =  xyz_row.browser 
			AND browser_version =  xyz_row.browser_version 
			AND (osversion IS NULL);
			user_agent_temp := NULL;
		ELSE
			SELECT xyz_row.browser||'/'||xyz_row.browser_version||' ('||xyz_row.osversion||')' INTO user_agent_temp;
			UPDATE bloomreadertest.mpdata_preview
			SET  context_user_agent = user_agent_temp
			WHERE browser =  xyz_row.browser 
				AND browser_version =  xyz_row.browser_version 
				AND osversion  =  xyz_row.osversion;
				user_agent_temp := NULL;
	END IF;
	RETURN NEXT xyz_row.browser;			
END LOOP;

EXCEPTION
   WHEN SQLSTATE '23000' THEN  -- Class 23 ? Integrity Constraint Violation
      GET STACKED DIAGNOSTICS err_constraint = CONSTRAINT_NAME;
      -- do something with it, for instance:
      RAISE NOTICE '%', err_constraint;
      RAISE;  -- raise original error
END;
$BODY$ LANGUAGE plpgsql;
	
--SELECT * FROM GENERATE_user_agent();

SELECT DISTINCT(a.user_id) from bloomreadertest.mpdata_preview AS a
	   ORDER BY a.user_id;

SELECT DISTINCT ON (a.browser, a.browser_version, a.osversion)
		a.browser, a.browser_version, a.osversion, a.context_user_agent 
		from bloomreadertest.mpdata_preview AS a
		WHERE a.browser IS NOT NULL;


SELECT a.browser, a.browser_version, a.osversion, 
		CASE WHEN a.browser_version IS NULL AND a.osversion IS NULL THEN a.browser 
			WHEN a.browser_version IS NULL THEN a.browser||' ('||a.osversion||')'
            WHEN a.osversion IS NULL THEN a.browser||'/'||a.browser_version
            ELSE a.browser||'/'||a.browser_version||' ('||a.osversion||')'
       END
    FROM bloomreadertest.clone_book_search AS a
	WHERE a.browser IS NOT NULL
	AND (a.browser_version IS NULL OR a.osversion IS NULL);