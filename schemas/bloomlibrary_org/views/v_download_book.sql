-- View: bloomlibrary_org.v_download_book

-- DROP VIEW bloomlibrary_org.v_download_book;

CREATE OR REPLACE VIEW bloomlibrary_org.v_download_book AS
    SELECT  timestamp as time_utc,
            --timestamp AT TIME ZONE context_timezone as time_local,
            --(timestamp AT TIME ZONE context_timezone)::DATE as date_local,
            --context_timezone,
            --INITCAP(to_char(timestamp AT TIME ZONE context_timezone, 'day')) as time_local_day,
            --CAST(date_part('hour', timestamp AT TIME ZONE context_timezone) AS INTEGER) as time_local_hour,        
            book as book_id,
            book_instance_id,
            COALESCE(event_type, 'shell') AS event_type,
            book_title,
            -- TODO: fill this in once it exists
            CAST(NULL AS TEXT) AS book_branding,
            c.country_name as country,
            c.region,
            c.city,
            topic
    FROM    bloomlibrary_org.download_book d
    left outer join public.countryregioncitylu c on d.location_uid = c.loc_uid
;


ALTER TABLE bloomlibrary_org.v_download_book
    OWNER TO silpgadmin;