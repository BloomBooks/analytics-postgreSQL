-- View: bloomreader.v_pages_read

-- DROP VIEW bloomreader.v_pages_read;

CREATE OR REPLACE VIEW bloomreader.v_pages_read AS

-- CAREFUL!
-- Any column changes here need to be reflected in bloomlibrary_org.v_pages_read
-- and vice versa because they are unioned in mv_pages_read.
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
        -- clean up old historical data; current BR deploys with 'Sample-Book'
         CASE
          when pr.title = 'The Moon and the Cap' and pr.branding_project_name = 'SIL-International' then 'Sample-Book'
          when pr.title = 'The Moon and the Cap' and pr.branding_project_name = 'Default' then 'Sample-Book'
          when pr.title = 'The Moon and the Cap' and pr.branding_project_name is NULL then 'Sample-Book'
          else pr.branding_project_name
         END AS book_branding,
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
        pr.channel,
        pr.video_pages_played,
        pr.features,
        pr.book_instance_id,
        pr.distribution_source,
        round(pr.latitude, 2) as latitude_approx,
        round(pr.longitude, 2) as longitude_approx,
        c_geo.country as country_geo,
        c_geo.region as region_geo,
        c_geo.city as city_geo,
        pr.location_source,
        pr.location_age_days,
        pr.bookshelves,
        pr.read_duration,
        pr.audio_duration,
        pr.video_duration,
        pr.host
FROM bloomreader.v_pages_read_raw pr
left outer join public.countryregioncitylu c on pr.location_uid = c.loc_uid 
left outer join public.v_geography_country_region_city c_geo on pr.city_center_id = c_geo.city_geoid
--left outer join public.languagecodes l on pr.content_lang = COALESCE(l.langid2, l.langid) -- where pr.location_uid = c.loc_uid

 -- omit records where phone's clock was obviously messed up
where pr.TIMESTAMP >= '2018-1-1'
    AND pr.TIMESTAMP < clock_timestamp();


ALTER TABLE bloomreader.v_pages_read OWNER TO silpgadmin;


select count(*)
from bloomreader.pages_read;