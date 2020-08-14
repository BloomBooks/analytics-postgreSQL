-- FUNCTION: common.refresh_materialized_views()

-- DROP FUNCTION common.refresh_materialized_views();

CREATE OR REPLACE FUNCTION common.refresh_materialized_views()
RETURNS void
AS $$

BEGIN

    REFRESH MATERIALIZED VIEW common.mv_book_detail;
    REFRESH MATERIALIZED VIEW common.mv_download_book;
    -- Some of the later views in this list use mv_pages_read, 
    -- so it needs to get refreshed before them.
    REFRESH MATERIALIZED VIEW common.mv_pages_read;
    REFRESH MATERIALIZED VIEW common.mv_comprehension;
    REFRESH MATERIALIZED VIEW common.mv_reading_perbook_events;
    REFRESH MATERIALIZED VIEW common.mv_reading_perday_events;
    REFRESH MATERIALIZED VIEW common.mv_reading_perday_events_by_branding_and_country;

END; $$

LANGUAGE 'plpgsql';