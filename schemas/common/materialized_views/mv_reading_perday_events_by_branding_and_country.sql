-- Materialized View: common.mv_reading_perday_events_by_branding_and_country

-- DROP MATERIALIZED VIEW common.mv_reading_perday_events_by_branding_and_country;

CREATE MATERIALIZED VIEW common.mv_reading_perday_events_by_branding_and_country AS

    -- Currently Bloom Reader only.
    -- If we want all reads, use common.mv_pages_read.
    SELECT  date_local,
            r.book_branding,
            r.country,
            count(*) as number_sessions
    FROM    bloomreader.v_pages_read r
    group by r.date_local,
            r.book_branding,
            r.country;