-- View: bloomreader.v_sessions_per_day

DROP VIEW bloomreader.v_sessions_per_day;


CREATE OR REPLACE VIEW bloomreader.v_sessions_per_day AS
select time_local::date as date_local,
       book_branding,
       country,
       count(*) as number_sessions
from bloomreader.v_pages_read
group by time_local::date,
         book_branding,
         country;

