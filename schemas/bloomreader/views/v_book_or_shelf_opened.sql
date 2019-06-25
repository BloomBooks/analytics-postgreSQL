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
         b.branding_project_name AS book_branding,
         b.content_lang AS book_language_code,
         b.question_count AS question_count,
         l.clname AS book_language,
         c.country_name AS country,
         c.region,
         c.city
   FROM bloomreader.book_or_shelf_opened b
     LEFT JOIN countryregioncitylu c ON b.location_uid = c.loc_uid
     LEFT JOIN languagecodes l ON b.content_lang = COALESCE(l.langid2, l.langid)::text
   -- omit records where phone's clock was obviously messed up 
  WHERE b."timestamp" >= '2018-01-01 00:00:00+00'::timestamp with time zone AND b."timestamp" < clock_timestamp();