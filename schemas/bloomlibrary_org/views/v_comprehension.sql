-- View: bloomlibrary_org.v_comprehension

-- DROP VIEW bloomlibrary_org.v_comprehension;

CREATE OR REPLACE VIEW bloomlibrary_org.v_comprehension AS

-- CAREFUL!
-- Any column changes here need to be reflected in bloomreader.v_comprehension
-- and vice versa because they are unioned in mv_comprehension.
SELECT  comp.timestamp as time_utc,
        -- We wish we could make all these actually accurate to local time
        -- as we do for Bloom Reader. But the web doesn't report timezone,
        -- so this is the best we can do, I think.
        comp.timestamp as time_local,
        (comp.timestamp)::DATE as date_local,
        NULL AS context_timezone,
        INITCAP(to_char(comp.timestamp, 'day')) as time_local_day,
        CAST(date_part('hour', comp.timestamp) AS INTEGER) as time_local_hour,
        comp.anonymous_id,
        NULL AS device_unique_id,
        NULL AS bloom_reader_version,
        comp.branding_project_name AS book_branding,        
        comp.title as book_title,
        comp.question_count,
        comp.percent_right,
        c.country_name as country,
        c.region,
        c.city,        
        NULL AS channel,
        comp.book_instance_id
FROM    bloomlibrary_org.comprehension comp
left outer join public.countryregioncitylu c on comp.location_uid = c.loc_uid
;