-- Table: bloomreadertest.clone2_create_book

-- DROP TABLE bloomreadertest.clone2_create_book;

CREATE TABLE bloomreadertest.clone2_create_book
(
    id character varying(1024) COLLATE pg_catalog."default" NOT NULL,
    received_at timestamp with time zone,
    uuid_ts timestamp with time zone,
    book_id text COLLATE pg_catalog."default",
    browser text COLLATE pg_catalog."default",
    category text COLLATE pg_catalog."default",
    channel text COLLATE pg_catalog."default",
    command_line text COLLATE pg_catalog."default",
    context_library_name text COLLATE pg_catalog."default",
    context_library_version text COLLATE pg_catalog."default",
    country text COLLATE pg_catalog."default",
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
    language1_iso639_code text COLLATE pg_catalog."default",
    language1_iso639_name text COLLATE pg_catalog."default",
    language2_iso639_code text COLLATE pg_catalog."default",
    language3_iso639_code text COLLATE pg_catalog."default",
    CONSTRAINT clone2_create_book_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.clone2_create_book
    OWNER to segment;

GRANT SELECT ON TABLE bloomreadertest.clone2_create_book TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.clone2_create_book TO readbloom;
GRANT ALL ON TABLE bloomreadertest.clone2_create_book TO segment;

-- Column: bloomreadertest.clone2_create_book.location_uid
-- ALTER TABLE bloomreadertest.clone2_create_book DROP COLUMN location_uid;
ALTER TABLE bloomreadertest.clone2_create_book
    ADD COLUMN location_uid bigint;	
	
select * from bloomreadertest.clone2_create_book;
SELECT MIN(b.timestamp) FROM bloomreadertest.clone2_create_book AS b;
-- Trigger: insert_country_row

-- DROP TRIGGER insert_country_row ON bloomreadertest.clone2_create_book;

--CREATE TRIGGER insert_country_row
--    BEFORE INSERT
--    ON bloomreadertest.clone2_create_book
--    FOR EACH ROW
--    EXECUTE PROCEDURE public.insert_ip_country_bloom_fctn();