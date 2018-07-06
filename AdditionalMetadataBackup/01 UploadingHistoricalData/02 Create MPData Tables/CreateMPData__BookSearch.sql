-- Table: bloomreadertest.mpdata_book_search

-- DROP TABLE bloomreadertest.mpdata_book_search;

CREATE TABLE bloomreadertest.mpdata_book_search
(
    id character varying(1024),
    received_at bigint,
   -- uuid_ts timestamp with time zone,
    all_licenses boolean,
   -- anonymous_id text COLLATE pg_catalog."default",
  --  context_ip text COLLATE pg_catalog."default",
    context_library_name text COLLATE pg_catalog."default",
    context_library_version text COLLATE pg_catalog."default",
    context_page_path text COLLATE pg_catalog."default",
    context_page_initial_referrer text COLLATE pg_catalog."default",
	context_page_referrer text COLLATE pg_catalog."default",
    context_page_initial_ref_domain text COLLATE pg_catalog."default",
	context_page_ref_domain text COLLATE pg_catalog."default",	
    source_for_context_page_search text COLLATE pg_catalog."default",
   -- context_page_title text COLLATE pg_catalog."default",
    context_page_url text COLLATE pg_catalog."default",
	--
	user_id text COLLATE pg_catalog."default",
	browser text COLLATE pg_catalog."default",
	browser_version text COLLATE pg_catalog."default",
	OS text COLLATE pg_catalog."default",
	screen_height bigint,
	screen_width bigint,
	device text COLLATE pg_catalog."default",
	search_engine text COLLATE pg_catalog."default",
	search_keyword text COLLATE pg_catalog."default",	
	utm_content text COLLATE pg_catalog."default",
	--
    --context_user_agent text COLLATE pg_catalog."default",
    event text COLLATE pg_catalog."default",
    event_text text COLLATE pg_catalog."default",
    lang text COLLATE pg_catalog."default",
   -- original_timestamp timestamp with time zone,
    search_string text COLLATE pg_catalog."default",
   -- sent_at timestamp with time zone,
    shelf text COLLATE pg_catalog."default",
    _tag text COLLATE pg_catalog."default",
   -- "timestamp" timestamp with time zone,
    context_campaign_source text COLLATE pg_catalog."default",
    context_campaign_term text COLLATE pg_catalog."default",
    context_campaign_name text COLLATE pg_catalog."default",
    context_campaign_medium text COLLATE pg_catalog."default",
    city text COLLATE pg_catalog."default",
    region text COLLATE pg_catalog."default",
    mp_country text COLLATE pg_catalog."default"	
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.mpdata_book_search
    OWNER to segment;

GRANT ALL ON TABLE bloomreadertest.mpdata_book_search TO segment;
GRANT SELECT ON TABLE bloomreadertest.mpdata_book_search TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.mpdata_book_search TO readbloomtester;

-- Column: bloomreadertest.mpdata_book_search.anonymous_id
-- ALTER TABLE bloomreadertest.mpdata_book_search DROP COLUMN anonymous_id;
ALTER TABLE bloomreadertest.mpdata_book_search
    ADD COLUMN anonymous_id text COLLATE pg_catalog."default";	
-- Column: bloomreadertest.mpdata_book_search.context_referrer
-- ALTER TABLE bloomreadertest.mpdata_book_search DROP COLUMN context_referrer;
ALTER TABLE bloomreadertest.mpdata_book_search
    ADD COLUMN context_referrer text COLLATE pg_catalog."default";
-- Column: bloomreadertest.mpdata_book_search.context_ref_domain
-- ALTER TABLE bloomreadertest.mpdata_book_search DROP COLUMN context_ref_domain;
ALTER TABLE bloomreadertest.mpdata_book_search
    ADD COLUMN context_ref_domain text COLLATE pg_catalog."default";	
	
ALTER TABLE bloomreadertest.mpdata_book_search
    ADD COLUMN context_user_agent text COLLATE pg_catalog."default";	
	
select * from bloomlibrary_org.book_search AS a
   WHERE a.context_page_title is not null;
  
select count(*), Count(DISTINCT(a.user_id)), Count(DISTINCT(a.anonymous_id))
	from bloomreadertest.mpdata_book_search AS a; 
	select a.anonymous_id from bloomreadertest.mpdata_book_search AS a;
select count(*), Count(DISTINCT(a.anonymous_id)) from bloomlibrary_org.book_search AS a;
select DISTINCT(a.anonymous_id) from bloomlibrary_org.book_search AS a;
select DISTINCT(a.uuid_ts) from bloomlibrary_org.book_search AS a;
select DISTINCT(a.user_id) from bloomreadertest.mpdata_book_search AS a;								
select * from bloomlibrary_org.book_search AS a
WHERE date_trunc('hour', a.timestamp) = date_trunc('hour',to_timestamp(1502074244)) ;
							
SELECT date_trunc('hour',to_timestamp(1502074244))  gen_random_uuid();
select count(*), Count(DISTINCT(a.anonymous_id)) from bloomlibrary_org.book_search AS a;
WHERE to_timestamp(a.received_at) > '2017-08-06 21:03:41.83+00';