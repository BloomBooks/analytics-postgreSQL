-- Table: bloomreadertest.mpdata_change_picture
-- DROP TABLE bloomreadertest.mpdata_change_picture;

CREATE TABLE bloomreadertest.mpdata_change_picture
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
    osversion text COLLATE pg_catalog."default",
    user_id text COLLATE pg_catalog."default",
    user_name text COLLATE pg_catalog."default",
    version text COLLATE pg_catalog."default",
    working_set text COLLATE pg_catalog."default",
    mp_country text COLLATE pg_catalog."default",
	city text COLLATE pg_catalog."default",
	region text COLLATE pg_catalog."default"
    --CONSTRAINT change_page_layout_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE bloomreadertest.mpdata_change_picture
    OWNER to segment;
GRANT SELECT ON TABLE bloomreadertest.mpdata_change_picture TO bloomappuser;
GRANT SELECT ON TABLE bloomreadertest.mpdata_change_picture TO readbloom;
GRANT ALL ON TABLE bloomreadertest.mpdata_change_picture TO segment;

-- Column: bloomreadertest.mpdata_change_picture.ip
-- ALTER TABLE bloomreadertest.mpdata_change_picture DROP COLUMN ip;
ALTER TABLE bloomreadertest.mpdata_change_picture
    ADD COLUMN ip text COLLATE pg_catalog."default";	

select * from bloomreadertest.mpdata_change_picture
 where command_line is not null;
select * from bloomapp.change_picture;
select * from bloomapp.change_picture
  where command_line <> '';


select MAX(to_timestamp(a.received_at )) from 
bloomreadertest.mpdata_change_picture AS a ;
SELECT to_timestamp(EXTRACT(EPOCH FROM INTERVAL '1369845877'));
SELECT to_timestamp('1369845877');
SELECT to_timestamp(a.received_at) from 
bloomreadertest.mpdata_change_picture AS a ;

select a.id from bloomreadertest.clone_change_content_languages AS a where a.timestamp::date > '2017-02-23';
select min (a.timestamp) from bloomreadertest.clone_change_content_languages AS a;