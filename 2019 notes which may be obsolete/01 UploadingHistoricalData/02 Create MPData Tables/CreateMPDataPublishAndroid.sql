-- Table: bloomreadertest.mpdata_publish_android

-- DROP TABLE bloomreadertest.mpdata_publish_android;

CREATE TABLE bloomreadertest.mpdata_publish_android
(
    id character varying(1024),
    received_at bigint,
    book_id text COLLATE pg_catalog."default",
    browser text COLLATE pg_catalog."default",
    channel text COLLATE pg_catalog."default",
    command_line text COLLATE pg_catalog."default",
    context_library_name text COLLATE pg_catalog."default",
    country text COLLATE pg_catalog."default",
    culture text COLLATE pg_catalog."default",
    current_directory text COLLATE pg_catalog."default",
    dot_net_version text COLLATE pg_catalog."default",
    event text COLLATE pg_catalog."default",
    event_text text COLLATE pg_catalog."default",
    full_version text COLLATE pg_catalog."default",
    language text COLLATE pg_catalog."default",
    mode text COLLATE pg_catalog."default", 
    osversion text COLLATE pg_catalog."default", 
    user_id text COLLATE pg_catalog."default",
    user_name text COLLATE pg_catalog."default",
    version text COLLATE pg_catalog."default",
    working_set text COLLATE pg_catalog."default",
    branding_project_name text COLLATE pg_catalog."default",
    collection_country text COLLATE pg_catalog."default",
    language1_iso639_code text COLLATE pg_catalog."default",
    language1_iso639_name text COLLATE pg_catalog."default",
    language2_iso639_code text COLLATE pg_catalog."default",
    language3_iso639_code text COLLATE pg_catalog."default",
    desktop_environment text COLLATE pg_catalog."default", 
    city text COLLATE pg_catalog."default",
    region text COLLATE pg_catalog."default",
    mp_country text COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.mpdata_publish_android
    OWNER to segment;

GRANT SELECT ON TABLE bloomreadertest.mpdata_publish_android TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.mpdata_publish_android TO readbloom;
GRANT ALL ON TABLE bloomreadertest.mpdata_publish_android TO segment;

select * from bloomreadertest.mpdata_publish_android;
SELECT MIN(b.timestamp) FROM bloomreadertest.mpdata_publish_android AS b;