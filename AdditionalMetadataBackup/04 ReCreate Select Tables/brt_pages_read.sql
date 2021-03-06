-- Table: bloomreadertest.pages_read

-- DROP TABLE bloomreadertest.pages_read;

CREATE TABLE bloomreadertest.pages_read
(
    id character varying(1024) COLLATE pg_catalog."default" NOT NULL,
    received_at timestamp with time zone,
    uuid_ts timestamp with time zone,
    anonymous_id text COLLATE pg_catalog."default",
    context_app_build bigint,
    context_app_name text COLLATE pg_catalog."default",
    context_app_namespace text COLLATE pg_catalog."default",
    context_app_version text COLLATE pg_catalog."default",
    context_device_id text COLLATE pg_catalog."default",
    context_device_manufacturer text COLLATE pg_catalog."default",
    context_device_model text COLLATE pg_catalog."default",
    context_device_name text COLLATE pg_catalog."default",
    context_device_type text COLLATE pg_catalog."default",
    context_ip text COLLATE pg_catalog."default",
    context_library_name text COLLATE pg_catalog."default",
    context_library_version text COLLATE pg_catalog."default",
    context_locale text COLLATE pg_catalog."default",
    context_major_minor text COLLATE pg_catalog."default",
    context_network_carrier text COLLATE pg_catalog."default",
    context_os_name text COLLATE pg_catalog."default",
    context_os_version text COLLATE pg_catalog."default",
    context_screen_density numeric,
    context_screen_height bigint,
    context_screen_width bigint,
    context_timezone text COLLATE pg_catalog."default",
    context_traits_anonymous_id text COLLATE pg_catalog."default",
    context_user_agent text COLLATE pg_catalog."default",
    event text COLLATE pg_catalog."default",
    event_text text COLLATE pg_catalog."default",
    last_page bigint,
    original_timestamp timestamp with time zone,
    sent_at timestamp with time zone,
    "timestamp" timestamp with time zone,
    title text COLLATE pg_catalog."default",
    audio_pages bigint,
    non_audio_pages bigint,
    context_traits_user_id text COLLATE pg_catalog."default",
    user_id text COLLATE pg_catalog."default",
    branding_project_name text COLLATE pg_catalog."default",
    context_network_bluetooth boolean,
    context_network_cellular boolean,
    context_network_wifi boolean,
    content_lang text COLLATE pg_catalog."default",
    last_numbered_page_read boolean,
    total_numbered_pages bigint,
    question_count bigint,
    CONSTRAINT pages_read_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.pages_read
    OWNER to segment;

GRANT SELECT ON TABLE bloomreadertest.pages_read TO readbloomtester;

GRANT ALL ON TABLE bloomreadertest.pages_read TO segment;

-- Index: language_idx1

-- DROP INDEX bloomreadertest.language_idx1;

CREATE INDEX language_idx1
    ON bloomreadertest.pages_read USING btree
    (content_lang COLLATE pg_catalog."default")
    TABLESPACE pg_default;

-- Index: title_idx1

-- DROP INDEX bloomreadertest.title_idx1;

CREATE INDEX title_idx1
    ON bloomreadertest.pages_read USING btree
    (lower(title) COLLATE pg_catalog."default")
    TABLESPACE pg_default;