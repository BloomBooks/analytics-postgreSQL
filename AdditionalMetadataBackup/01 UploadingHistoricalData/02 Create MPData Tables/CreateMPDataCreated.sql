-- Table: bloomreadertest.mpdata_created

-- DROP TABLE bloomreadertest.mpdata_created;

CREATE TABLE bloomreadertest.mpdata_created
(
    id character varying(1024),
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
    ip text COLLATE pg_catalog."default",
    osversion text COLLATE pg_catalog."default",
    user_id text COLLATE pg_catalog."default",
    user_name text COLLATE pg_catalog."default",
    version text COLLATE pg_catalog."default",
    working_set text COLLATE pg_catalog."default",
	city text COLLATE pg_catalog."default",
	region text COLLATE pg_catalog."default",
	mp_country text COLLATE pg_catalog."default"
	--,
    --CONSTRAINT mpdata_created_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.mpdata_created
    OWNER to segment;

GRANT SELECT ON TABLE bloomreadertest.mpdata_created TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.mpdata_created TO readbloom;
GRANT ALL ON TABLE bloomreadertest.mpdata_created TO segment;


	
	select * from bloomreadertest.mpdata_created;