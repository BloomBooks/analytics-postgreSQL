-- Table: bloomreadertest.mpdata_upload_book_failure_system_time

-- DROP TABLE bloomreadertest.mpdata_upload_book_failure_system_time;

CREATE TABLE bloomreadertest.mpdata_upload_book_failure_system_time
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
    dot_net_version text COLLATE pg_catalog."default",
    event text COLLATE pg_catalog."default",
    event_text text COLLATE pg_catalog."default",
    full_version text COLLATE pg_catalog."default",
    --ip text COLLATE pg_catalog."default",
    osversion text COLLATE pg_catalog."default",
    user_id text COLLATE pg_catalog."default",
    user_name text COLLATE pg_catalog."default",
    version text COLLATE pg_catalog."default",
    working_set text COLLATE pg_catalog."default",
    city text COLLATE pg_catalog."default",
    region text COLLATE pg_catalog."default",
    mp_country text COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.mpdata_upload_book_failure_system_time
    OWNER to segment;

GRANT SELECT ON TABLE bloomreadertest.mpdata_upload_book_failure_system_time TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.mpdata_upload_book_failure_system_time TO readbloom;
GRANT ALL ON TABLE bloomreadertest.mpdata_upload_book_failure_system_time TO segment;

-- ALTER TABLE bloomreadertest.mpdata_upgrade DROP COLUMN location_uid;
ALTER TABLE bloomreadertest.mpdata_upload_book_failure_system_time
    ADD COLUMN location_uid bigint;	
	
select * from bloomreadertest.mpdata_upload_book_failure_system_time;
SELECT MIN(b.timestamp) FROM bloomreadertest.mpdata_upload_book_failure_system_time AS b;