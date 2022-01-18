-- Table: bloomreadertest.mpdata_identifies

-- DROP TABLE bloomreadertest.mpdata_identifies;

CREATE TABLE bloomreadertest.mpdata_identifies
(
    id character varying(1024) ,
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
    uilanguage text COLLATE pg_catalog."default",
    user_id text COLLATE pg_catalog."default",
    how_iuse_it text COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.mpdata_identifies
    OWNER to segment;

GRANT SELECT ON TABLE bloomreadertest.mpdata_identifies TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.mpdata_identifies TO readbloom;
GRANT ALL ON TABLE bloomreadertest.mpdata_identifies TO segment;

select * from bloomreadertest.mpdata_identifies;