-- View: bloomreader.v_number_pages_read_by_book

-- DROP VIEW bloomreader.v_number_pages_read_by_book;

CREATE OR REPLACE VIEW bloomreader.v_number_pages_read_by_book AS

select book_title,
    sum(pages_read_audio) as number_audio_pages_played,
    sum(pages_read_nonaudio) as number_nonaudio_pages_read,
    book_branding,
    country,
    max(book_pages) as max_number_pages
from bloomreader.v_pages_read
group by book_title,
    book_branding,
    country;