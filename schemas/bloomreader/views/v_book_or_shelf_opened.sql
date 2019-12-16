-- View: bloomreader.v_book_or_shelf_opened

-- DROP VIEW bloomreader.v_book_or_shelf_opened;

CREATE OR REPLACE VIEW bloomreader.v_book_or_shelf_opened AS

 SELECT  b."timestamp" AS time_utc,
         b.context_timezone,
         b.timestamp AT TIME ZONE b.context_timezone as time_local,
         (b.timestamp AT TIME ZONE b.context_timezone)::DATE as date_local,
         initcap(to_char(timezone(b.context_timezone, b."timestamp"), 'day'::text)) AS time_local_day,
         date_part('hour'::text, timezone(b.context_timezone, b."timestamp"))::integer AS time_local_hour,
         b.anonymous_id,
         b.context_device_id as device_unique_id,
         b.context_traits_user_id as device_project_hardware_code, -- comes from deviceId.json, if found on the device
         b.context_major_minor AS bloom_reader_version,
         b.title AS book_title,
         -- clean up old historical data; current BR deploys with 'Sample-Book'
         CASE
          when b.title = 'The Moon and the Cap' and b.branding_project_name = 'SIL-International' then 'Sample-Book'
          when b.title = 'The Moon and the Cap' and b.branding_project_name = 'Default' then 'Sample-Book'
          when b.title = 'The Moon and the Cap' and b.branding_project_name is NULL then 'Sample-Book'
          else b.branding_project_name
         END AS book_branding,
         b.content_lang AS book_language_code,
         b.question_count AS question_count,
         l.clname AS book_language,
         c.country_name AS country,
         c.region,
         c.city,
         b.channel,
         context_device_manufacturer AS device_manufacturer,
         context_device_model AS device_model
   FROM bloomreader.v_book_or_shelf_opened_raw b
     LEFT JOIN public.countryregioncitylu c ON b.location_uid = c.loc_uid
     LEFT JOIN public.languagecodes l ON b.content_lang = COALESCE(l.langid2, l.langid)::text
   -- omit records where phone's clock was obviously messed up 
  WHERE b."timestamp" >= '2018-01-01 00:00:00+00'::timestamp with time zone AND b."timestamp" < clock_timestamp();