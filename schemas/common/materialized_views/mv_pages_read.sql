-- Materialized View: common.mv_pages_read

-- DROP MATERIALIZED VIEW common.mv_pages_read;

CREATE MATERIALIZED VIEW common.mv_pages_read AS
    SELECT  *,
            'bloomreader' as source
    FROM    bloomreader.v_pages_read
    UNION ALL
    SELECT  *,
            'bloomlibrary' as source
    FROM    bloomlibrary_org.v_pages_read
    ;

-- Be sure to recreate these if you need to drop the view.
CREATE INDEX book_instance_id
    ON common.mv_pages_read USING btree
    (book_instance_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX book_instance_id_and_source
    ON common.mv_pages_read USING btree
    (book_instance_id COLLATE pg_catalog."default" ASC NULLS LAST, 
    source COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX book_instance_id_and_source_and_date_local
    ON common.mv_pages_read USING btree
    (book_instance_id COLLATE pg_catalog."default" ASC NULLS LAST, 
    source COLLATE pg_catalog."default" ASC NULLS LAST, 
    date_local ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX book_instance_id_and_date_local
    ON common.mv_pages_read USING btree
    (book_instance_id COLLATE pg_catalog."default" ASC NULLS LAST, 
    date_local ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX book_branding_and_source
    ON common.mv_pages_read USING btree
    (book_branding COLLATE pg_catalog."default" ASC NULLS LAST, 
    source COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;