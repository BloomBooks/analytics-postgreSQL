-- View: bloomreader.v_comprehension_raw

-- DROP VIEW bloomreader.v_comprehension_raw;

CREATE OR REPLACE VIEW bloomreader.v_comprehension_raw AS

-- questions_correct was the event sent by Bloom Reader v1
-- comprehension is the event sent by Bloom Reader v2 (via bloom-player)
SELECT  'release' as channel,
        timestamp,
        context_timezone,
        anonymous_id,
        context_device_id,
        context_major_minor,
        title,
        branding_project_name,
        location_uid,
        question_count,
        percent_right,
        book_instance_id,
        cast(null as BIGINT) as city_center_id,
        null as distribution_source,
        null as host,
        cast(null as NUMERIC) as latitude,
        cast(null as NUMERIC) as longitude,
        null as location_source,
        null as bookshelves,
        cast(null as NUMERIC) as location_age_days
FROM    bloomreader.questions_correct
UNION ALL
SELECT  'beta' as channel,
        timestamp,
        context_timezone,
        anonymous_id,
        context_device_id,
        context_major_minor,
        title,
        branding_project_name,
        location_uid,
        question_count,
        percent_right,
        book_instance_id,
        cast(null as BIGINT) as city_center_id,
        null as distribution_source,
        null as host,
        cast(null as NUMERIC) as latitude,
        cast(null as NUMERIC) as longitude,
        null as location_source,
        null as bookshelves,
        cast(null as NUMERIC) as location_age_days
FROM    bloomreaderbeta.questions_correct
UNION ALL
SELECT  'release' as channel,
        timestamp,
        context_timezone,
        anonymous_id,
        context_device_id,
        context_major_minor,
        title,
        branding_project_name,
        location_uid,
        question_count,
        percent_right,
        book_instance_id,
        city_center_id,
        distribution_source,
        host,
        latitude,
        longitude,
        location_source,
        bookshelves,
        location_age_days
FROM    bloomreader.comprehension
UNION ALL
SELECT  'beta' as channel,
        timestamp,
        context_timezone,
        anonymous_id,
        context_device_id,
        context_major_minor,
        title,
        branding_project_name,
        location_uid,
        question_count,
        percent_right,
        book_instance_id,
        city_center_id,
        distribution_source,
        host,
        latitude,
        longitude,
        location_source,
        bookshelves,
        location_age_days
FROM    bloomreaderbeta.comprehension
;