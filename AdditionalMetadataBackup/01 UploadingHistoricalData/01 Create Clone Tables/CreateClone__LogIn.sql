-- Table: bloomreadertest.clone_log_in

-- DROP TABLE bloomreadertest.clone_log_in;

CREATE TABLE bloomreadertest.clone_log_in
(
    id character varying(1024) COLLATE pg_catalog."default" NOT NULL,
    received_at timestamp with time zone,
    uuid_ts timestamp with time zone,
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
    original_timestamp timestamp with time zone,
    sent_at timestamp with time zone,
    "timestamp" timestamp with time zone,
    username text COLLATE pg_catalog."default",
    CONSTRAINT log_in_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.clone_log_in
    OWNER to segment;


GRANT ALL ON TABLE bloomreadertest.clone_log_in TO segment;
GRANT SELECT ON TABLE bloomreadertest.clone_log_in TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.clone_log_in TO readbloomtester;

-- Column: bloomreadertest.clone_log_in.location_uid
-- ALTER TABLE bloomreadertest.clone_log_in DROP COLUMN location_uid;
ALTER TABLE bloomreadertest.clone_log_in
    ADD COLUMN context_campaign_source text COLLATE pg_catalog."default" NULL,
    ADD COLUMN context_campaign_term text COLLATE pg_catalog."default" NULL,
    ADD COLUMN context_campaign_name text COLLATE pg_catalog."default" NULL,
    ADD COLUMN context_campaign_medium text COLLATE pg_catalog."default" NULL,
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

select * from bloomreadertest.clone_log_in;
SELECT MIN(b.timestamp) FROM bloomreadertest.clone_log_in AS b;