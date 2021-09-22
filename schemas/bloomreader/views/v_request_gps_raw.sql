-- View: bloomreader.v_request_gps_raw

-- DROP VIEW bloomreader.v_request_gps_raw;

CREATE OR REPLACE VIEW bloomreader.v_request_gps_raw AS

SELECT  timestamp,
        context_timezone,
        anonymous_id,
        context_device_id,
        context_major_minor,
        'release' as channel,
        granted
FROM    bloomreader.request_gps
UNION ALL
SELECT  timestamp,
        context_timezone,
        anonymous_id,
        context_device_id,
        context_major_minor,
        'beta' as channel,
        granted
FROM    bloomreaderbeta.request_gps;

