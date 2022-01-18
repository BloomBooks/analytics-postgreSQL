--DROP FUNCTION ACTUALmigrate_MPData_pages();

CREATE OR REPLACE FUNCTION ACTUALmigrate_MPData_pages()
RETURNS SETOF varchar AS $BODY$
DECLARE time_max_for_historical_data timestamp;
DECLARE new_id varchar(1024);
DECLARE err_constraint varchar(100);
DECLARE country_code_temp varchar(2);
DECLARE country_name_temp varchar(64);
DECLARE region_temp varchar(100);
DECLARE city_temp varchar(100);
DECLARE hold_country_code varchar(2);
DECLARE hold_country_name varchar(64);
DECLARE hold_region varchar(100);
DECLARE hold_city varchar(100);
DECLARE loc_uid_temp bigint;
DECLARE counter bigint;
DECLARE xyz CURSOR FOR SELECT * from bloomreadertest.mpdata_pages AS a
      WHERE to_timestamp(a.received_at) < time_max_for_historical_data 
	   ORDER BY a.mp_country, a.region, a.city;
DECLARE xyz_row RECORD;
BEGIN
new_id := '';
SELECT MAX(c.loc_uid) FROM public.countryregioncitylu AS c INTO counter;
SELECT MIN(b.timestamp) FROM bloomlibrary_org.pages AS b 
 		into time_max_for_historical_data ;
FOR xyz_row IN xyz
    LOOP
	new_id := '';
	country_code_temp := NULL;
	country_name_temp := NULL;
	region_temp := NULL;
	city_temp := NULL;
	hold_country_code := NULL;
	hold_country_name := NULL;
	hold_region := NULL;
	hold_city := NULL;	
	SELECT gen_random_uuid() INTO new_id;
	country_code_temp := public.empty_to_null(xyz_row.mp_country);
	region_temp := public.empty_to_null(xyz_row.region);
	city_temp := public.empty_to_null(xyz_row.city);
	IF country_code_temp ='-' or country_code_temp IS NULL THEN 
	   country_code_temp := '-';
	END IF;	
	IF region_temp ='-' or region_temp IS NULL THEN 
	   region_temp := '-';
	END IF;
	IF city_temp ='-' or city_temp IS NULL THEN 
	   city_temp := '-';
	END IF;	
	SELECT DISTINCT (d.countryname) FROM public.countrycodes AS d 
		WHERE  d.countrycode = country_code_temp  INTO country_name_temp;	
	IF public.empty_to_null(country_name_temp) IS NULL THEN
		SELECT DISTINCT (e.country_name) FROM public.ipv42location AS e 
		WHERE  e.country_code = country_code_temp  INTO country_name_temp;
		IF public.empty_to_null(country_name_temp) IS NULL THEN
			country_name_temp := '-';
		END IF;
	END IF;
	
	loc_uid_temp := NULL;
	SELECT i.loc_uid from public.countryregioncitylu AS i
		where i.country_code = country_code_temp
		AND i.region = region_temp
		AND i.city = city_temp
		INTO loc_uid_temp;
	IF loc_uid_temp IS NULL THEN
        counter := counter + CAST('1' AS bigint);
		loc_uid_temp := counter ;
		INSERT INTO  public.countryregioncitylu as p  
		( loc_uid, country_code, country_name, region, city  )  
		VALUES
		( loc_uid_temp, country_code_temp, country_name_temp, region_temp, city_temp ) ;
	END IF;

   	INSERT INTO bloomlibrary_org.pages  
	( id, received_at, anonymous_id, context_user_agent, browser, browser_version,
	 -- user_name, book, book_title, href,
	  context_library_name, context_library_version, --context_page_path, 
	  context_page_referrer, context_page_referrer_domain, context_page_search,
	  context_page_url, osversion, screen_height, screen_width, device, 
	  search_engine, search_keyword, 
	  --utm_content, 
	  event, event_text, name, path, referrer, search, title, url, 
	  --lang, search_string, shelf, _tag, 
	  context_campaign_source, context_campaign_term, context_campaign_name, context_campaign_medium,
	  original_timestamp, sent_at, timestamp,  
	  location_uid )
	VALUES
	(new_id, to_timestamp(xyz_row.received_at), 
	  public.empty_to_null(xyz_row.anonymous_id), public.empty_to_null(xyz_row.context_user_agent),
	  public.empty_to_null(xyz_row.browser), public.empty_to_null(xyz_row.browser_version),
	 -- public.empty_to_null(xyz_row.user_name),
	 -- public.empty_to_null(xyz_row.book), public.empty_to_null(xyz_row.book_title),public.empty_to_null(xyz_row.href),
 	  public.empty_to_null(xyz_row.context_library_name), 
	  public.empty_to_null(xyz_row.context_library_version),
	  --public.empty_to_null(xyz_row.context_page_path),
	  public.empty_to_null(xyz_row.context_page_referrer), 
	  public.empty_to_null(xyz_row.context_page_ref_domain),
	  public.empty_to_null(xyz_row.source_for_context_page_search),
	  public.empty_to_null(xyz_row.context_page_url), public.empty_to_null(xyz_row.osversion),
	  xyz_row.screen_height, xyz_row.screen_width,
	  public.empty_to_null(xyz_row.device), public.empty_to_null(xyz_row.search_engine),
	  public.empty_to_null(xyz_row.search_keyword), --public.empty_to_null(xyz_row.utm_content), 
	  public.empty_to_null(xyz_row.event), public.empty_to_null(xyz_row.event_text), 
	  public.empty_to_null(xyz_row.name), public.empty_to_null(xyz_row.path), 
	  public.empty_to_null(xyz_row.referrer), public.empty_to_null(xyz_row.search), 
	  public.empty_to_null(xyz_row.title), public.empty_to_null(xyz_row.url),
	  --public.empty_to_null(xyz_row.search_string), 
	  --public.empty_to_null(xyz_row.shelf), public.empty_to_null(xyz_row._tag), 
	  public.empty_to_null(xyz_row.context_campaign_source),
	  public.empty_to_null(xyz_row.context_campaign_term) ,
	  public.empty_to_null(xyz_row.context_campaign_name) ,
	  public.empty_to_null(xyz_row.context_campaign_medium),
	  to_timestamp(xyz_row.received_at), 
	  to_timestamp(xyz_row.received_at), to_timestamp(xyz_row.received_at),
	  loc_uid_temp );
     	--ON CONFLICT ON CONSTRAINT clone_created_pkey DO NOTHING;
	RETURN NEXT xyz_row.mp_country;			
END LOOP;

EXCEPTION
   WHEN SQLSTATE '23000' THEN  -- Class 23 Integrity Constraint Violation
      GET STACKED DIAGNOSTICS err_constraint = CONSTRAINT_NAME;
      -- do something with it, for instance:
      RAISE NOTICE '%', err_constraint;
      RAISE;  -- raise original error
END;
$BODY$ LANGUAGE plpgsql;

-- Column: bloomreadertest.clone_pages.location_uid
-- ALTER TABLE bloomreadertest.clone_pages DROP COLUMN location_uid;
ALTER TABLE bloomlibrary_org.pages
    ADD COLUMN location_uid bigint;	
	
SELECT * from bloomreadertest.mpdata_pages AS a
	WHERE POSITION('Mix' IN a.context_library_name)>0;
      WHERE to_timestamp(a.received_at) < '2017-08-07 09:57:22.415+00'	
SELECT MIN(b.timestamp) FROM bloomlibrary_org.pages AS b
 
   	UPDATE bloomreadertest.mpdata_pages
	SET  context_library_name = context_library_name||' via Mixpanel';
	
   	UPDATE bloomlibrary_org.pages
	SET  context_library_name = context_library_name||' via Mixpanel'
	WHERE timestamp < '2017-08-10 17:04:21.861+00'; 
--SELECT * FROM ACTUALmigrate_MPData_pages();

select * from bloomlibrary_org.pages
  WHERE POSITION('Mix' IN context_library_name)>0;
select to_timestamp('1522771253');
SELECT MIN(b.timestamp) FROM bloomlibrary_org.pages AS b
select count(*) from bloomlibrary_org.pages;
select count(*) from bloomreadertest.mpdata_pages;
select count(*) from bloomreadertest.mpdata_upload_book_success AS a
 where to_timestamp(a.received_at) < (SELECT MIN(b.timestamp) FROM bloomreadertest.clone_upload_book_success AS b);
SELECT * from bloomreadertest.clone_upload_book_success AS a;
SELECT * from bloomreadertest.mpdata_upload_book_success AS a
       WHERE to_timestamp(a.received_at) < 
	   (SELECT MIN(b.timestamp) FROM bloomreadertest.clone_upload_book_success AS b) 
	   ORDER BY a.mp_country, a.region, a.city;





