-- Materialized View: common.mv_download_book

-- DROP MATERIALIZED VIEW common.mv_download_book;

CREATE MATERIALIZED VIEW common.mv_download_book AS
    SELECT  *
    FROM    bloomlibrary_org.v_download_book;

-- Be sure to recreate these if you need to drop the view.
CREATE INDEX idx_mvdownload_book_id
    ON common.mv_download_book USING btree
    (book_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_mvdownload_book_instance_id
    ON common.mv_download_book USING btree
    (book_instance_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_mvdownload_book_id_and_time_utc
    ON common.mv_download_book USING btree
    (book_id COLLATE pg_catalog."default" ASC NULLS LAST, time_utc ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_mvdownload_book_id_and_time_utc_and_event_type
    ON common.mv_download_book USING btree
    (book_id COLLATE pg_catalog."default" ASC NULLS LAST, time_utc ASC NULLS LAST, event_type COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;