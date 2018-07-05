-- Column: bloomreaderbeta.pages_read.country_name

-- ALTER TABLE bloomreaderbeta.pages_read DROP COLUMN country_name;

ALTER TABLE bloomreaderbeta.pages_read
    ADD COLUMN country_name character varying(64) COLLATE pg_catalog."default" NULL;