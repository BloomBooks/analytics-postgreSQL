-- Table: bloomreadertest.clone_insert_template_page

-- DROP TABLE bloomreadertest.clone_insert_template_page;

CREATE TABLE bloomreadertest.clone_insert_template_page
(
    id character varying(1024) COLLATE pg_catalog."default" NOT NULL,
    received_at timestamp with time zone,
    uuid_ts timestamp with time zone,
    browser text COLLATE pg_catalog."default",
    channel text COLLATE pg_catalog."default",
    command_line text COLLATE pg_catalog."default",
    context_library_name text COLLATE pg_catalog."default",
    context_library_version text COLLATE pg_catalog."default",
    culture text COLLATE pg_catalog."default",
    current_directory text COLLATE pg_catalog."default",
    desktop_environment text COLLATE pg_catalog."default",
    dot_net_version text COLLATE pg_catalog."default",
    event text COLLATE pg_catalog."default",
    event_text text COLLATE pg_catalog."default",
    full_version text COLLATE pg_catalog."default",
    original_timestamp timestamp with time zone,
    osversion text COLLATE pg_catalog."default",
    page text COLLATE pg_catalog."default",
    sent_at timestamp with time zone,
    template_source text COLLATE pg_catalog."default",
    "timestamp" timestamp with time zone,
    user_id text COLLATE pg_catalog."default",
    user_name text COLLATE pg_catalog."default",
    version text COLLATE pg_catalog."default",
    working_set text COLLATE pg_catalog."default",
    CONSTRAINT clone_insert_template_page_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.clone_insert_template_page
    OWNER to segment;

GRANT SELECT ON TABLE bloomreadertest.clone_insert_template_page TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.clone_insert_template_page TO readbloom;
GRANT ALL ON TABLE bloomreadertest.clone_insert_template_page TO segment;

-- Column: bloomreadertest.clone_insert_template_page.location_uid
-- ALTER TABLE bloomreadertest.clone_insert_template_page DROP COLUMN location_uid;
ALTER TABLE bloomreadertest.clone_insert_template_page
    ADD COLUMN location_uid bigint;	
	
	
select * from bloomreadertest.clone_insert_template_page;