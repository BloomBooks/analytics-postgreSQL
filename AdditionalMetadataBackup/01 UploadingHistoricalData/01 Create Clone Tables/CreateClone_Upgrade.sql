-- Table: bloomreadertest.clone_upgrade

-- DROP TABLE bloomreadertest.clone_upgrade;

CREATE TABLE bloomreadertest.clone_upgrade
(
    id character varying(1024) COLLATE pg_catalog."default" NOT NULL,
    received_at timestamp with time zone,
    uuid_ts timestamp with time zone,
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
    old_version text COLLATE pg_catalog."default",
    original_timestamp timestamp with time zone,
    osversion text COLLATE pg_catalog."default",
    sent_at timestamp with time zone,
    "timestamp" timestamp with time zone,
    user_id text COLLATE pg_catalog."default",
    user_name text COLLATE pg_catalog."default",
    version text COLLATE pg_catalog."default",
    working_set text COLLATE pg_catalog."default",
    ip text COLLATE pg_catalog."default",
    CONSTRAINT clone_upgrade_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.clone_upgrade
    OWNER to segment;

GRANT SELECT ON TABLE bloomreadertest.clone_upgrade TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.clone_upgrade TO readbloom;
GRANT ALL ON TABLE bloomreadertest.clone_upgrade TO segment;

-- ALTER TABLE bloomreadertest.clone_upgrade DROP COLUMN location_uid;
ALTER TABLE bloomreadertest.clone_upgrade
    ADD COLUMN location_uid bigint;	
	
select * from bloomreadertest.clone_upgrade;
SELECT MIN(b.timestamp) FROM bloomreadertest.clone_upgrade AS b;