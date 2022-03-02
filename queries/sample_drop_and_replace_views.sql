BEGIN;

DROP VIEW bloomreader.v_pages_read_covicef;
DROP VIEW bloomreader.v_pages_read_rise;
DROP VIEW bloomreader.v_pages_read_save_western;
DROP VIEW bloomreader.v_pages_read_yrt;
DROP MATERIALIZED VIEW common.mv_reading_perbook_events;
DROP VIEW common.v_pages_read_chetana;
DROP VIEW common.v_pages_read_efl;

DROP MATERIALIZED VIEW common.mv_pages_read;




DROP VIEW bloomlibrary_org.v_pages_read;

CREATE OR REPLACE VIEW bloomlibrary_org.v_pages_read AS

-- CAREFUL!
-- Any column changes here need to be reflected in bloomreader.v_pages_read
-- and vice versa because they are unioned in mv_pages_read.
SELECT  pr.timestamp as time_utc,
        -- We wish we could make all these actually accurate to local time
        -- as we do for Bloom Reader. But the web doesn't report timezone,
        -- so this is the best we can do, I think.
        pr.timestamp as time_local,
        pr.timestamp::DATE as date_local,
        NULL as context_timezone,
        INITCAP(to_char(pr.timestamp, 'day')) as time_local_day,
        CAST(date_part('hour', pr.timestamp) AS INTEGER) as time_local_hour,
        pr.audio_pages as pages_read_audio,
        pr.non_audio_pages as pages_read_nonaudio,
        pr.audio_pages + pr.non_audio_pages as pages_read,
        pr.anonymous_id,
        NULL as device_unique_id,
        NULL as device_project_hardware_code,
        NULL as bloom_reader_version,
        pr.title as book_title,
        pr.branding_project_name AS book_branding,
        pr.content_lang as book_language_code,
         -- Including this in the view makes it very slow when
         -- filtering on country and branding. So we punted and 
         -- "removed" it, but since the view is in use by other
         -- views, it was much easier to create this dummy value.
        --l.clname as book_language,
        CHARACTER VARYING(50) 'error: language name lookup failed' as book_language,
        pr.total_numbered_pages as book_pages,
        pr.last_numbered_page_read as finished_reading_book,
        c.country_name as country,
        c.region,
        c.city,
        NULL as channel,
        pr.video_pages as video_pages_played,
        pr.features,
        pr.book_instance_id,
        NULL AS distribution_source,
        CAST(NULL AS NUMERIC) AS latitude_approx,
        CAST(NULL AS NUMERIC) AS longitude_approx,
        NULL AS country_geo,
        NULL AS region_geo,
        NULL AS city_geo,
        NULL AS location_source,
        CAST(NULL AS NUMERIC) AS location_age_days,
        pr.bookshelves,
        pr.read_duration,
        pr.audio_duration,
        pr.video_duration,
        pr.host,
        CAST(NULL AS NUMERIC) AS city_latitude_geo,
        CAST(NULL AS NUMERIC) AS city_longitude_geo,
        NULL AS country_code_geo,
        NULL AS country_code
FROM bloomlibrary_org.pages_read pr
left outer join public.countryregioncitylu c on pr.location_uid = c.loc_uid
--left outer join public.languagecodes l on pr.content_lang = COALESCE(l.langid2, l.langid) -- where pr.location_uid = c.loc_uid
;



CREATE MATERIALIZED VIEW common.mv_pages_read AS
    SELECT  *,
            'bloomreader' as source
    FROM    bloomreader.v_pages_read
    UNION ALL
    SELECT  *,
            'bloomlibrary' as source
    FROM    bloomlibrary_org.v_pages_read
    ;

-- Be sure to recreate these if you need to drop the view.
CREATE INDEX book_instance_id
    ON common.mv_pages_read USING btree
    (book_instance_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX book_instance_id_and_source
    ON common.mv_pages_read USING btree
    (book_instance_id COLLATE pg_catalog."default" ASC NULLS LAST, 
    source COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX book_instance_id_and_source_and_date_local
    ON common.mv_pages_read USING btree
    (book_instance_id COLLATE pg_catalog."default" ASC NULLS LAST, 
    source COLLATE pg_catalog."default" ASC NULLS LAST, 
    date_local ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX book_instance_id_and_date_local
    ON common.mv_pages_read USING btree
    (book_instance_id COLLATE pg_catalog."default" ASC NULLS LAST, 
    date_local ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX book_branding_and_source
    ON common.mv_pages_read USING btree
    (book_branding COLLATE pg_catalog."default" ASC NULLS LAST, 
    source COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

GRANT SELECT ON TABLE common.mv_pages_read TO stats;


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


CREATE OR REPLACE VIEW bloomreader.v_pages_read_covicef AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'PNG-COVICEF'
;

GRANT SELECT ON TABLE bloomreader.v_pages_read_covicef TO bloomreader_inclusiv;
GRANT SELECT ON TABLE bloomreader.v_pages_read_covicef TO readbloom;



CREATE OR REPLACE VIEW bloomreader.v_pages_read_rise AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'PNG-RISE' AND
        source = 'bloomreader'
;

GRANT SELECT ON TABLE bloomreader.v_pages_read_rise TO bloomreader_inclusiv;
GRANT SELECT ON TABLE bloomreader.v_pages_read_rise TO readbloom;
GRANT SELECT ON TABLE bloomreader.v_pages_read_rise TO bloomreader_rise;



CREATE OR REPLACE VIEW bloomreader.v_pages_read_save_western AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'PNG-WesternProvinceELearning-2020' AND
        source = 'bloomreader'
;

GRANT SELECT ON TABLE bloomreader.v_pages_read_save_western TO bloomreader_inclusiv;
GRANT SELECT ON TABLE bloomreader.v_pages_read_save_western TO readbloom;
GRANT SELECT ON TABLE bloomreader.v_pages_read_save_western TO bloomreader_save_western;



CREATE OR REPLACE VIEW bloomreader.v_pages_read_yrt AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'PNG-UnrestrICTed-Yumi'
;

GRANT SELECT ON TABLE bloomreader.v_pages_read_yrt TO bloomreader_inclusiv;
GRANT SELECT ON TABLE bloomreader.v_pages_read_yrt TO readbloom;


CREATE OR REPLACE VIEW common.v_pages_read_chetana AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'Chetana-Trust'
;

GRANT SELECT ON TABLE common.v_pages_read_chetana TO read_chetana;
GRANT SELECT ON TABLE common.v_pages_read_chetana TO readbloom;



CREATE OR REPLACE VIEW common.v_pages_read_efl AS

SELECT  *
FROM    common.mv_pages_read
WHERE   book_branding = 'Education-For-Life' or book_branding = 'Education-For-Life-SE'
;

GRANT SELECT ON TABLE common.v_pages_read_efl TO read_education_for_life;
GRANT SELECT ON TABLE common.v_pages_read_efl TO readbloom;



COMMIT;

