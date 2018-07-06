-- Table: bloomreadertest.mpdata_change_page_layout

-- DROP TABLE bloomreadertest.mpdata_change_page_layout;

CREATE TABLE bloomreadertest.mpdata_change_page_layout
(
    id character varying(1024) COLLATE pg_catalog."default",
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
    new_layout text COLLATE pg_catalog."default",
    old_lineage text COLLATE pg_catalog."default",
    osversion text COLLATE pg_catalog."default",
    user_id text COLLATE pg_catalog."default",
    user_name text COLLATE pg_catalog."default",
    version text COLLATE pg_catalog."default",
    working_set text COLLATE pg_catalog."default",
    language1_iso639_name text COLLATE pg_catalog."default",
    collection_country text COLLATE pg_catalog."default",
    country text COLLATE pg_catalog."default",
    language1_iso639_code text COLLATE pg_catalog."default",
    branding_project_name text COLLATE pg_catalog."default",
    language2_iso639_code text COLLATE pg_catalog."default",
    language3_iso639_code text COLLATE pg_catalog."default",
	city text COLLATE pg_catalog."default",
	region text COLLATE pg_catalog."default",
	mp_country text COLLATE pg_catalog."default"
    --CONSTRAINT change_page_layout_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.mpdata_change_page_layout
    OWNER to segment;
GRANT SELECT ON TABLE bloomreadertest.mpdata_change_page_layout TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.mpdata_change_page_layout TO readbloom;
GRANT ALL ON TABLE bloomreadertest.mpdata_change_page_layout TO segment;

select * from bloomreadertest.mpdata_change_page_layout;

SELECT to_timestamp(EXTRACT(EPOCH FROM INTERVAL '1369845877'));
SELECT to_timestamp('1369845877');
SELECT to_timestamp(a.received_at) from 
bloomreadertest.mpdata_change_page_layout AS a ;

select a.id from bloomreadertest.clone_change_content_languages AS a where a.timestamp::date > '2017-02-23';
select min (a.timestamp) from bloomreadertest.clone_change_content_languages AS a;