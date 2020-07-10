-- Materialized View: common.mv_comprehension

-- DROP MATERIALIZED VIEW common.mv_comprehension

CREATE MATERIALIZED VIEW common.mv_comprehension AS
    SELECT  *
    FROM bloomreader.v_comprehension;
