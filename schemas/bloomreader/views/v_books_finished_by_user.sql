-- View: bloomreader.v_books_finished_by_user

-- DROP VIEW bloomreader.v_books_finished_by_user;

CREATE OR REPLACE VIEW bloomreader.v_books_finished_by_user AS

select 
    anonymous_id, 
    COUNT(*) as num_books_finished, 
    COUNT(DISTINCT book_title) as num_distinct_books_finished,
    book_branding, 
    country
from 
    bloomreader.v_pages_read
where 
    finished_reading_book='True'
group by 
    anonymous_id, 
    book_branding, 
    country