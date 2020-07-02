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
        'release' AS channel,
        context_device_manufacturer,
        context_device_model,
        features,
        book_instance_id
FROM    bloomreader.book_or_shelf_opened
UNION ALL
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
        'beta' AS channel,
        context_device_manufacturer,
        context_device_model,
        features,
        book_instance_id
FROM    bloomreaderbeta.book_or_shelf_opened;