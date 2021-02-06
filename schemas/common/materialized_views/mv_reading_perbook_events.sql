-- Materialized View: common.mv_reading_perbook_events

-- DROP MATERIALIZED VIEW common.mv_reading_perbook_events;

CREATE MATERIALIZED VIEW common.mv_reading_perbook_events AS
-- We think it's better to get the book_title based on the mode of ALL DAY's data, not just a single day's data

        WITH    dataPerBook AS
                (SELECT book_instance_id,
                        MODE() WITHIN GROUP (ORDER BY book_title) AS book_title,
                        MODE() WITHIN GROUP (ORDER BY book_language_code) AS book_language_code
                FROM    common.mv_pages_read
                group by book_instance_id
                )
        SELECT  r.book_instance_id,
                MAX(dataPerBook.book_title) AS book_title,
                r.book_branding,
                r.country,
                MAX(dataPerBook.book_language_code) AS book_language_code,
                count(*) started, 
                sum(r.finished_reading_book::int) finished,
                r.date_local
        FROM    common.mv_pages_read r
        INNER JOIN dataPerBook
                ON r.book_instance_id = dataPerBook.book_instance_id
        WHERE   r.book_instance_id is not null
        group by r.book_instance_id,
                r.book_branding,
                r.country,
                r.date_local
        ;

GRANT SELECT ON TABLE common.mv_reading_perbook_events TO stats;