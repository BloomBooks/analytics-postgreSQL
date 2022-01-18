-- Table: bloomreader.questions_correct

-- DROP TABLE bloomreader.questions_correct;

CREATE TABLE bloomreader.questions_correct
(
    id character varying(1024) COLLATE pg_catalog."default" NOT NULL,
    received_at timestamp with time zone,
    sent_at timestamp with time zone,
    title text COLLATE pg_catalog."default",
    uuid_ts timestamp with time zone,
    event_text text COLLATE pg_catalog."default",
    branding_project_name text COLLATE pg_catalog."default",
    context_device_manufacturer text COLLATE pg_catalog."default",
    context_device_name text COLLATE pg_catalog."default",
    context_ip text COLLATE pg_catalog."default",
    context_locale text COLLATE pg_catalog."default",
    context_screen_width bigint,
    context_app_build bigint,
    context_network_wifi boolean,
    context_os_version text COLLATE pg_catalog."default",
    context_app_version text COLLATE pg_catalog."default",
    context_library_name text COLLATE pg_catalog."default",
    context_network_cellular boolean,
    context_screen_height bigint,
    percent_right bigint,
    context_device_model text COLLATE pg_catalog."default",
    context_network_bluetooth boolean,
    context_screen_density numeric,
    context_user_agent text COLLATE pg_catalog."default",
    context_app_namespace text COLLATE pg_catalog."default",
    event text COLLATE pg_catalog."default",
    right_first_time bigint,
    "timestamp" timestamp with time zone,
    context_major_minor text COLLATE pg_catalog."default",
    context_network_carrier text COLLATE pg_catalog."default",
    context_timezone text COLLATE pg_catalog."default",
    context_traits_anonymous_id text COLLATE pg_catalog."default",
    original_timestamp timestamp with time zone,
    question_count bigint,
    anonymous_id text COLLATE pg_catalog."default",
    context_app_name text COLLATE pg_catalog."default",
    context_device_id text COLLATE pg_catalog."default",
    context_device_type text COLLATE pg_catalog."default",
    context_library_version text COLLATE pg_catalog."default",
    context_os_name text COLLATE pg_catalog."default",
    context_traits_user_id text COLLATE pg_catalog."default",
    user_id text COLLATE pg_catalog."default",
    CONSTRAINT questions_correct_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreader.questions_correct
    OWNER to segment;

GRANT SELECT ON TABLE bloomreader.questions_correct TO readbloomtester;

GRANT ALL ON TABLE bloomreader.questions_correct TO segment;

-- Index: title_idx2

-- DROP INDEX bloomreader.title_idx2;

CREATE INDEX title_idx2
    ON bloomreader.questions_correct USING btree
    (lower(title) COLLATE pg_catalog."default")
    TABLESPACE pg_default;