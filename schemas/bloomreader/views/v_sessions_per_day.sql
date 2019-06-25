-- View: bloomreader.v_sessions_per_day

-- DROP VIEW bloomreader.v_sessions_per_day;

CREATE OR REPLACE VIEW bloomreader.v_sessions_per_day AS

select time_utc::date as date,
    count(*) as number_sessions
from bloomreader.v_pages_read
group by date;
