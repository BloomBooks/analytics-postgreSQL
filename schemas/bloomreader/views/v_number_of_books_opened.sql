-- View: bloomreader.v_number_of_books_opened

-- DROP VIEW bloomreader.v_number_of_books_opened;

CREATE OR REPLACE VIEW bloomreader.v_number_of_books_opened AS

select anonymous_id, 
    count(distinct book_title) as number_of_books_opened,
    book_branding,
    country
from bloomreader.v_book_or_shelf_opened
group by anonymous_id,
    book_branding,
    country;


