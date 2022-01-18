-- Table: bloomreadertest.mpdata_upload_book_success

-- DROP TABLE bloomreadertest.mpdata_upload_book_success;

CREATE TABLE bloomreadertest.mpdata_upload_book_success
(
    id character varying(1024) ,
    received_at bigint,
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
   -- ip text COLLATE pg_catalog."default",
    osversion text COLLATE pg_catalog."default",
    title text COLLATE pg_catalog."default",
    url text COLLATE pg_catalog."default",
    user_id text COLLATE pg_catalog."default",
    user_name text COLLATE pg_catalog."default",
    version text COLLATE pg_catalog."default",
    working_set text COLLATE pg_catalog."default",
    branding_project_name text COLLATE pg_catalog."default",
    language1_iso639_code text COLLATE pg_catalog."default",
    language1_iso639_name text COLLATE pg_catalog."default",
    language2_iso639_code text COLLATE pg_catalog."default",
	language3_iso639_code text COLLATE pg_catalog."default",
    collection_country text COLLATE pg_catalog."default",
    country text COLLATE pg_catalog."default",
    city text COLLATE pg_catalog."default",
    region text COLLATE pg_catalog."default",
    mp_country text COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.mpdata_upload_book_success
    OWNER to segment;

GRANT SELECT ON TABLE bloomreadertest.mpdata_upload_book_success TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.mpdata_upload_book_success TO readbloom;
GRANT ALL ON TABLE bloomreadertest.mpdata_upload_book_success TO readbloomtester;
GRANT ALL ON TABLE bloomreadertest.mpdata_upload_book_success TO segment;

-- ALTER TABLE bloomreadertest.mpdata_upload_book_success DROP COLUMN location_uid;
ALTER TABLE bloomreadertest.mpdata_upload_book_success
    ADD COLUMN location_uid bigint;	
	
select * from bloomreadertest.mpdata_upload_book_success;
SELECT MIN(b.timestamp) FROM bloomreadertest.mpdata_upload_book_success AS b;