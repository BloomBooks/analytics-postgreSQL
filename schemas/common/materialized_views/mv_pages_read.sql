-- Materialized View: common.mv_pages_read

-- DROP MATERIALIZED VIEW common.mv_pages_read;

CREATE MATERIALIZED VIEW common.mv_pages_read AS
    SELECT  *
    FROM bloomreader.v_pages_read;
