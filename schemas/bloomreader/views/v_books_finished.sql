-- View: bloomreader.v_books_finished

-- DROP VIEW bloomreader.v_books_finished;

CREATE OR REPLACE VIEW bloomreader.v_books_finished AS

select 
    book_title,
    count(*) opened, 
    sum(finished_reading_book::int) finished,
    sum(finished_reading_book::int)::float/count(*) percentage_finished,
    book_branding,
    country
from bloomreader.v_pages_read
group by book_title,
    book_branding,
    country;