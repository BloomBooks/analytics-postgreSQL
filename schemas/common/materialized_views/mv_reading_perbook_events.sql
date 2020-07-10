-- Materialized View: common.mv_reading_perbook_events

-- DROP MATERIALIZED VIEW common.mv_reading_perbook_events;

CREATE MATERIALIZED VIEW common.mv_reading_perbook_events AS

    SELECT  r.book_instance_id,
            MODE() WITHIN GROUP (ORDER BY r.book_title) AS book_title,
            r.book_branding,
            r.country,
            MODE() WITHIN GROUP (ORDER BY r.book_language_code) AS book_language_code,
            count(*) started, 
            sum(r.finished_reading_book::int) finished,
            r.date_local
    FROM    bloomreader.v_pages_read r
    WHERE   book_instance_id is not null
    group by r.book_instance_id,
            r.book_branding,
            r.country,
            r.date_local;