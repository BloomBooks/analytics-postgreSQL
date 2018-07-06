-- Table: bloomreadertest.clone_identifies

-- DROP TABLE bloomreadertest.clone_identifies;

CREATE TABLE bloomreadertest.clone_identifies
(
    id character varying(1024) COLLATE pg_catalog."default" NOT NULL,
    received_at timestamp with time zone,
    uuid_ts timestamp with time zone,
    browser text COLLATE pg_catalog."default",
    context_ip text COLLATE pg_catalog."default",
    context_language text COLLATE pg_catalog."default",
    context_library_name text COLLATE pg_catalog."default",
    context_library_version text COLLATE pg_catalog."default",
    email text COLLATE pg_catalog."default",
    first_name text COLLATE pg_catalog."default",
    how_using text COLLATE pg_catalog."default",
    last_name text COLLATE pg_catalog."default",
    organization text COLLATE pg_catalog."default",
    original_timestamp timestamp with time zone,
    sent_at timestamp with time zone,
    "timestamp" timestamp with time zone,
    uilanguage text COLLATE pg_catalog."default",
    user_id text COLLATE pg_catalog."default",
    how_iuse_it text COLLATE pg_catalog."default",
    CONSTRAINT clone_identifies_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.clone_identifies
    OWNER to segment;

GRANT SELECT ON TABLE bloomreadertest.clone_identifies TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.clone_identifies TO readbloom;
GRANT ALL ON TABLE bloomreadertest.clone_identifies TO segment;

-- Column: bloomreadertest.clone_identifies.location_uid
-- ALTER TABLE bloomreadertest.clone_identifies DROP COLUMN location_uid;
ALTER TABLE bloomreadertest.clone_identifies
    ADD COLUMN location_uid bigint;	
	
select * from bloomreadertest.clone_identifies;