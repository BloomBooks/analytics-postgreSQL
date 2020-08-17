-- View: bloomreader.v_comprehension

-- DROP VIEW bloomreader.v_comprehension;

CREATE OR REPLACE VIEW bloomreader.v_comprehension AS

-- CAREFUL!
-- Any column changes here need to be reflected in bloomlibrary_org.v_comprehension
-- and vice versa because they are unioned in mv_comprehension.
SELECT  comp.timestamp as time_utc,
        comp.timestamp AT TIME ZONE comp.context_timezone as time_local,
        (comp.timestamp AT TIME ZONE comp.context_timezone)::DATE as date_local,
        comp.context_timezone,
        INITCAP(to_char(comp.timestamp AT TIME ZONE comp.context_timezone, 'day')) as time_local_day,
        CAST(date_part('hour', comp.timestamp AT TIME ZONE comp.context_timezone) AS INTEGER) as time_local_hour,
        comp.anonymous_id,
        comp.context_device_id as device_unique_id,
        comp.context_major_minor as bloom_reader_version,
        -- clean up old historical data; current BR deploys with 'Sample-Book'
         CASE
          when comp.title = 'The Moon and the Cap' and comp.branding_project_name = 'SIL-International' then 'Sample-Book'
          when comp.title = 'The Moon and the Cap' and comp.branding_project_name = 'Default' then 'Sample-Book'
          when comp.title = 'The Moon and the Cap' and comp.branding_project_name is NULL then 'Sample-Book'
          else comp.branding_project_name
         END AS book_branding,        
        comp.title as book_title,
        comp.question_count,
        comp.percent_right,
        c.country_name as country,
        c.region,
        c.city,        
        comp.channel,
        comp.book_instance_id
FROM    bloomreader.v_comprehension_raw comp
left outer join public.countryregioncitylu c on comp.location_uid = c.loc_uid

 -- omit records where phone's clock was obviously messed up
where comp.TIMESTAMP >= '2018-1-1'
    AND comp.TIMESTAMP < clock_timestamp();