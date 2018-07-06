-- Table: bloomreadertest.clone_book_search

-- DROP TABLE bloomreadertest.clone_book_search;

CREATE TABLE bloomreadertest.clone_book_search
(
    id character varying(1024) COLLATE pg_catalog."default" NOT NULL,
    received_at timestamp with time zone,
    uuid_ts timestamp with time zone,
    all_licenses boolean,
    anonymous_id text COLLATE pg_catalog."default",
    context_ip text COLLATE pg_catalog."default",
    context_library_name text COLLATE pg_catalog."default",
    context_library_version text COLLATE pg_catalog."default",
    context_page_path text COLLATE pg_catalog."default",
    context_page_referrer text COLLATE pg_catalog."default",
    context_page_search text COLLATE pg_catalog."default",
    context_page_title text COLLATE pg_catalog."default",
    context_page_url text COLLATE pg_catalog."default",
    context_user_agent text COLLATE pg_catalog."default",
    event text COLLATE pg_catalog."default",
    event_text text COLLATE pg_catalog."default",
    lang text COLLATE pg_catalog."default",
    original_timestamp timestamp with time zone,
    search_string text COLLATE pg_catalog."default",
    sent_at timestamp with time zone,
    shelf text COLLATE pg_catalog."default",
    _tag text COLLATE pg_catalog."default",
    "timestamp" timestamp with time zone,
    context_campaign_source text COLLATE pg_catalog."default",
    context_campaign_term text COLLATE pg_catalog."default",
    context_campaign_name text COLLATE pg_catalog."default",
    context_campaign_medium text COLLATE pg_catalog."default",
    CONSTRAINT book_search_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.clone_book_search
    OWNER to segment;

GRANT ALL ON TABLE bloomreadertest.clone_book_search TO segment;
GRANT SELECT ON TABLE bloomreadertest.clone_book_search TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.clone_book_search TO readbloomtester;

-- Column: bloomreadertest.clone_book_search.location_uid
-- ALTER TABLE bloomreadertest.clone_book_search DROP COLUMN location_uid;
ALTER TABLE bloomreadertest.clone_book_search
    ADD COLUMN location_uid bigint;	

select * from bloomreadertest.clone_book_search;
SELECT MIN(b.timestamp) FROM bloomreadertest.clone_book_search AS b;