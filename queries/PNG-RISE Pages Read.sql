SELECT 
    a."timestamp" as time_stamp,
    
    CAST(date_part('hour', a.timestamp AT TIME ZONE 'PGT') AS INTEGER) as time_png_hour,
    to_char(a.timestamp AT TIME ZONE 'PGT',  'day') as time_png_weekday,
        a.audio_pages as pages_read_audio,
    a.non_audio_pages as pages_read_nonaudio,
    a.audio_pages + a.non_audio_pages as pages_read,
    a.anonymous_id as device_unique_id,
    a.context_traits_user_id as device_project_hardware_code, -- comes from deviceId.json, if found on the device
    a.context_major_minor as bloom_reader_version,
    a.title as book_title,
    a.branding_project_name as book_branding, -- even though they will all say "RISE PNG", this gives client confidence in what he is seeing
    a.content_lang as book_language,
    a.total_numbered_pages as book_pages,

    a.last_numbered_page_read as finished_reading_book
   FROM bloomreader.pages_read a
    WHERE a.branding_project_name = 'PNG-RISE' 
    AND (a.location_uid IN ( SELECT b.loc_uid
           FROM countryregioncitylu b
          WHERE b.country_name = 'Papua New Guinea'))