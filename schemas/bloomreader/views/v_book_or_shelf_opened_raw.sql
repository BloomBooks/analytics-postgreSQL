-- View: bloomreader.v_book_or_shelf_opened_raw

-- DROP VIEW bloomreader.v_book_or_shelf_opened_raw;

CREATE OR REPLACE VIEW bloomreader.v_book_or_shelf_opened_raw AS

SELECT  timestamp,
        context_timezone,
        anonymous_id,
        context_device_id,
        context_traits_user_id,
        context_major_minor,
        title,
        question_count,
        branding_project_name,
        content_lang,
        location_uid,
        'release' AS channel
FROM    bloomreader.book_or_shelf_opened
UNION
SELECT  timestamp,
        context_timezone,
        anonymous_id,
        context_device_id,
        context_traits_user_id,
        context_major_minor,
        title,
        question_count,
        branding_project_name,
        content_lang,
        location_uid,
        'beta' AS channel
FROM    bloomreaderbeta.book_or_shelf_opened;