-- Materialized View: common.mv_book_detail

-- DROP MATERIALIZED VIEW common.mv_book_detail;

CREATE MATERIALIZED VIEW common.mv_book_detail AS
    SELECT  *
    FROM    bloomlibrary_org.v_book_detail;
