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
        book_instance_id
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
        book_instance_id
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
        book_instance_id
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
        book_instance_id
FROM    bloomreaderbeta.comprehension
;