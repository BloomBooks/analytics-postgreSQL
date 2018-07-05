-- Table: bloomreader.application_installed

-- DROP TABLE bloomreader.application_installed;

CREATE TABLE bloomreader.application_installed
(
    id character varying(1024) COLLATE pg_catalog."default" NOT NULL,
    received_at timestamp with time zone,
    uuid_ts timestamp with time zone,
    anonymous_id text COLLATE pg_catalog."default",
    build bigint,
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
    original_timestamp timestamp with time zone,
    sent_at timestamp with time zone,
    "timestamp" timestamp with time zone,
    version text COLLATE pg_catalog."default",
    context_network_cellular boolean,
    context_network_bluetooth boolean,
    context_network_wifi boolean,
    CONSTRAINT application_installed_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreader.application_installed
    OWNER to segment;

GRANT ALL ON TABLE bloomreader.application_installed TO segment;