-- View: bloomreader.v_number_pages_read_by_book

-- DROP VIEW bloomreader.v_number_pages_read_by_book;

CREATE OR REPLACE VIEW bloomreader.v_number_pages_read_by_book AS

select title,
    sum(audio_pages) as number_audio_pages_played,
    sum(non_audio_pages) as number_nonaudio_pages_read,
    branding_project_name,
    country_name,
    max(total_numbered_pages) as max_number_pages
from bloomreader.pages_read
group by title,
    branding_project_name,
    country_name
order by 3 desc;