-- Materialized View: common.mv_download_book

-- DROP MATERIALIZED VIEW common.mv_download_book;

CREATE MATERIALIZED VIEW common.mv_download_book AS
    SELECT  *
    FROM    bloomlibrary_org.v_download_book;
