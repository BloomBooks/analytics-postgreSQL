SELECT pr."timestamp" as time_stamp,
       CAST(date_part('hour', pr.timestamp AT TIME ZONE 'PGT') AS INTEGER) as time_png_hour,
       CAST(extract(dow from (pr.timestamp AT TIME ZONE 'PGT')) AS INTEGER) as day_of_weekN,
       to_char(pr.timestamp AT TIME ZONE 'PGT', 'day') as day_of_week,
       pr.audio_pages as pages_read_audio,
       pr.non_audio_pages as pages_read_nonaudio,
       pr.audio_pages + pr.non_audio_pages as pages_read,
       pr.anonymous_id as device_unique_id,
       pr.context_traits_user_id as device_project_hardware_code, -- comes from deviceId.json, if found on the device
 pr.context_major_minor as bloom_reader_version,
 pr.title as book_title,
 pr.branding_project_name as book_branding, -- even though they will all say "RISE PNG", this gives client confidence in what he is seeing
 pr.content_lang as book_language,
 pr.total_numbered_pages as book_pages,
 pr.last_numbered_page_read as finished_reading_book
FROM bloomreader.pages_read pr
WHERE pr.branding_project_name = 'PNG-RISE'
    AND (pr.location_uid IN
             (SELECT b.loc_uid
              FROM countryregioncitylu b
              WHERE b.country_name = 'Papua New Guinea'))
