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
        'release' as channel
FROM    bloomreader.pages_read
UNION
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
        'beta' as channel
FROM    bloomreaderbeta.pages_read;

