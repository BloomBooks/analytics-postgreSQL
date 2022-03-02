-- View: bloomlibrary_org.v_pages_read

-- DROP VIEW bloomlibrary_org.v_pages_read;

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
        CAST(c.country_code AS TEXT) AS country_code
FROM bloomlibrary_org.pages_read pr
left outer join public.countryregioncitylu c on pr.location_uid = c.loc_uid
--left outer join public.languagecodes l on pr.content_lang = COALESCE(l.langid2, l.langid) -- where pr.location_uid = c.loc_uid
;

