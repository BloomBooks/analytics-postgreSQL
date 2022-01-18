-- Table: bloomreadertest.mpdata_pages

-- DROP TABLE bloomreadertest.mpdata_pages;

CREATE TABLE bloomreadertest.mpdata_pages
(
    id character varying(1024) ,
    received_at bigint,
    --uuid_ts timestamp with time zone,
	user_id text COLLATE pg_catalog."default",
    anonymous_id text COLLATE pg_catalog."default",
    context_campaign_medium text COLLATE pg_catalog."default",
    context_campaign_name text COLLATE pg_catalog."default",
    context_campaign_source text COLLATE pg_catalog."default",
    context_campaign_term text COLLATE pg_catalog."default",
    --context_ip text COLLATE pg_catalog."default",
    context_library_name text COLLATE pg_catalog."default",
    context_library_version text COLLATE pg_catalog."default",
    context_page_path text COLLATE pg_catalog."default",
    context_page_initial_referrer text COLLATE pg_catalog."default",
	context_page_referrer text COLLATE pg_catalog."default",
    context_page_initial_ref_domain text COLLATE pg_catalog."default",
	context_page_ref_domain text COLLATE pg_catalog."default",
    source_for_context_page_search text COLLATE pg_catalog."default",
    --context_page_title text COLLATE pg_catalog."default",
    context_page_url text COLLATE pg_catalog."default",
    context_user_agent text COLLATE pg_catalog."default",
 	event text COLLATE pg_catalog."default",
	event_text text COLLATE pg_catalog."default",	
    name text COLLATE pg_catalog."default",
  --  original_timestamp timestamp with time zone,
    path text COLLATE pg_catalog."default",
    referrer text COLLATE pg_catalog."default",
    search text COLLATE pg_catalog."default",
   -- sent_at timestamp with time zone,
   -- "timestamp" timestamp with time zone,
    title text COLLATE pg_catalog."default",
    url text COLLATE pg_catalog."default",
   -- CONSTRAINT log_out_pkey PRIMARY KEY (id)
	browser text COLLATE pg_catalog."default",
	browser_version text COLLATE pg_catalog."default",
	osversion text COLLATE pg_catalog."default",
	screen_height bigint,
	screen_width bigint,
	device text COLLATE pg_catalog."default",
	search_engine text COLLATE pg_catalog."default",
	search_keyword text COLLATE pg_catalog."default",	
	--utm_content text COLLATE pg_catalog."default",
	--
    city text COLLATE pg_catalog."default",
    region text COLLATE pg_catalog."default",
    mp_country text COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.mpdata_pages
    OWNER to segment;

GRANT ALL ON TABLE bloomreadertest.mpdata_pages TO segment;
GRANT SELECT ON TABLE bloomreadertest.mpdata_pages TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.mpdata_pages TO readbloomtester;

-- Column: bloomreadertest.mpdata_pages.location_uid
-- ALTER TABLE bloomreadertest.mpdata_pages DROP COLUMN location_uid;
ALTER TABLE bloomreadertest.mpdata_pages
    --ADD COLUMN context_campaign_source text COLLATE pg_catalog."default" NULL,
    --ADD COLUMN context_campaign_term text COLLATE pg_catalog."default" NULL,
    --ADD COLUMN context_campaign_name text COLLATE pg_catalog."default" NULL,
    --ADD COLUMN context_campaign_medium text COLLATE pg_catalog."default" NULL,
	ADD COLUMN context_page_referrer_domain text COLLATE pg_catalog."default" NULL,
	ADD COLUMN search_engine text COLLATE pg_catalog."default" NULL,
	ADD COLUMN search_keyword text COLLATE pg_catalog."default" NULL,
	ADD COLUMN browser text COLLATE pg_catalog."default" NULL,
	ADD COLUMN browser_version text COLLATE pg_catalog."default" NULL,
	ADD COLUMN osversion text COLLATE pg_catalog."default" NULL,
	ADD COLUMN device text COLLATE pg_catalog."default" NULL,
	ADD COLUMN screen_height bigint NULL,
	ADD COLUMN screen_width bigint NULL,
    ADD COLUMN location_uid bigint;	

select * from bloomreadertest.mpdata_pages;
SELECT MIN(b.timestamp) FROM bloomreadertest.mpdata_pages AS b;
