-- Table: bloomreadertest.mpdata_download_book

-- DROP TABLE bloomreadertest.mpdata_download_book;

CREATE TABLE bloomreadertest.mpdata_download_book
(
    id character varying(1024),
    received_at bigint,
    user_id text COLLATE pg_catalog."default",
	anonymous_id text COLLATE pg_catalog."default",
    book text COLLATE pg_catalog."default",
    book_title text COLLATE pg_catalog."default",
   -- context_ip text COLLATE pg_catalog."default",
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
    context_user_agent text COLLATE pg_catalog."default",
    event text COLLATE pg_catalog."default",
    event_text text COLLATE pg_catalog."default",
    href text COLLATE pg_catalog."default",
   -- original_timestamp timestamp with time zone,
   -- sent_at timestamp with time zone,
   -- "timestamp" timestamp with time zone,
   -- CONSTRAINT download_book_pkey PRIMARY KEY (id)
	--
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

ALTER TABLE bloomreadertest.mpdata_download_book
    OWNER to segment;

GRANT ALL ON TABLE bloomreadertest.mpdata_download_book TO segment;
GRANT SELECT ON TABLE bloomreadertest.mpdata_download_book TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.mpdata_download_book TO readbloomtester;

select * from bloomreadertest.mpdata_download_book;
SELECT MIN(b.timestamp) FROM bloomreadertest.mpdata_download_book AS b;

   	UPDATE bloomreadertest.mpdata_download_book 
	SET  context_library_name = context_library_name||' via Mixpanel';