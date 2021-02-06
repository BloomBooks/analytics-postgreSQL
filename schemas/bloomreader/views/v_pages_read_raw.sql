-- View: bloomreader.v_pages_read_raw

-- DROP VIEW bloomreader.v_pages_read_raw;

CREATE OR REPLACE VIEW bloomreader.v_pages_read_raw AS

SELECT  timestamp,
        context_timezone,
        audio_pages,
        non_audio_pages,
        anonymous_id,
        context_device_id,
        context_traits_user_id,
        context_major_minor,
        title,
        total_numbered_pages,
        last_numbered_page_read,
        branding_project_name,
        content_lang,
        location_uid,
        'release' as channel,
        COALESCE(video_pages, video_pages_played) as video_pages_played,
        features,
        book_instance_id,
        city_center_id,
        distribution_source,
        host,
        latitude,
        longitude
FROM    bloomreader.pages_read
UNION ALL
SELECT  timestamp,
        context_timezone,
        audio_pages,
        non_audio_pages,
        anonymous_id,
        context_device_id,
        context_traits_user_id,
        context_major_minor,
        title,
        total_numbered_pages,
        last_numbered_page_read,
        branding_project_name,
        content_lang,
        location_uid,
        'beta' as channel,
        COALESCE(video_pages, video_pages_played) as video_pages_played,
        features,
        book_instance_id,
        city_center_id,
        distribution_source,
        host,
        latitude,
        longitude
FROM    bloomreaderbeta.pages_read;

