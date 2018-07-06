-- Table: bloomreadertest.clone_change_content_languages

-- DROP TABLE bloomreadertest.clone_change_content_languages;

CREATE TABLE bloomreadertest.clone_change_content_languages
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
    ip text COLLATE pg_catalog."default",
    original_timestamp timestamp with time zone,
    osversion text COLLATE pg_catalog."default",
    sent_at timestamp with time zone,
    "timestamp" timestamp with time zone,
    user_id text COLLATE pg_catalog."default",
    user_name text COLLATE pg_catalog."default",
    version text COLLATE pg_catalog."default",
    working_set text COLLATE pg_catalog."default",
    branding_project_name text COLLATE pg_catalog."default",
    collection_country text COLLATE pg_catalog."default",
    country text COLLATE pg_catalog."default",
    language1_iso639_code text COLLATE pg_catalog."default",
    language1_iso639_name text COLLATE pg_catalog."default",
    language2_iso639_code text COLLATE pg_catalog."default",
    language3_iso639_code text COLLATE pg_catalog."default",
    CONSTRAINT clone_change_content_languages_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.clone_change_content_languages
    OWNER to segment;

GRANT SELECT ON TABLE bloomreadertest.clone_change_content_languages TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.clone_change_content_languages TO readbloomtester;
GRANT ALL ON TABLE bloomreadertest.clone_change_content_languages TO segment;

-- Column: bloomreadertest.clone_change_content_languages.location_uid
-- ALTER TABLE bloomreadertest.clone_change_content_languages DROP COLUMN location_uid;
ALTER TABLE bloomreadertest.clone_change_content_languages
    ADD COLUMN location_uid bigint;	