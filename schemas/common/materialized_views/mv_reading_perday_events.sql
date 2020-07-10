-- Materialized View: common.mv_reading_perday_events

-- DROP MATERIALIZED VIEW common.mv_reading_perday_events;

CREATE MATERIALIZED VIEW common.mv_reading_perday_events AS

    SELECT  book_instance_id,
            date_local,
            r.book_branding,
            r.country,
            count(*) as number_sessions
    FROM    bloomreader.v_pages_read r
    group by r.book_instance_id,
            r.date_local,
            r.book_branding,
            r.country;