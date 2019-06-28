-- View: bloomreader.v_pages_read

-- DROP VIEW bloomreader.v_pages_read ;

CREATE OR REPLACE VIEW bloomreader.v_pages_read AS

SELECT  pr.timestamp as time_utc,
        pr.timestamp AT TIME ZONE pr.context_timezone as time_local,
        (pr.timestamp AT TIME ZONE pr.context_timezone)::DATE as date_local,
        pr.context_timezone,
        INITCAP(to_char(pr.timestamp AT TIME ZONE pr.context_timezone, 'day')) as time_local_day,
        CAST(date_part('hour', pr.timestamp AT TIME ZONE pr.context_timezone) AS INTEGER) as time_local_hour,
        pr.audio_pages as pages_read_audio,
        pr.non_audio_pages as pages_read_nonaudio,
        pr.audio_pages + pr.non_audio_pages as pages_read,
        pr.anonymous_id,
        pr.context_device_id as device_unique_id,
        pr.context_traits_user_id as device_project_hardware_code, -- comes from deviceId.json, if found on the device
        pr.context_major_minor as bloom_reader_version,
        pr.title as book_title,
        pr.branding_project_name as book_branding,
        pr.content_lang as book_language_code,
        l.clname as book_language,
        pr.total_numbered_pages as book_pages,
        pr.last_numbered_page_read as finished_reading_book,
        c.country_name as country,
        c.region,
        c.city,
        pr.channel
FROM bloomreader.v_pages_read_raw pr
left outer join public.countryregioncitylu c on pr.location_uid = c.loc_uid
left outer join public.languagecodes l on pr.content_lang = COALESCE(l.langid2, l.langid) -- where pr.location_uid = c.loc_uid

 -- omit records where phone's clock was obviously messed up
where pr.TIMESTAMP >= '2018-1-1'
    AND pr.TIMESTAMP < clock_timestamp();


ALTER TABLE bloomreader.v_pages_read OWNER TO silpgadmin;


select count(*)
from bloomreader.pages_read;