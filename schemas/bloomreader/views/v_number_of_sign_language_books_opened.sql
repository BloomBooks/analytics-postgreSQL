-- View: bloomreader.v_number_of_sign_language_books_opened

-- DROP VIEW bloomreader.v_number_of_sign_language_books_opened;

CREATE OR REPLACE VIEW bloomreader.v_number_of_sign_language_books_opened AS

select anonymous_id, 
    count(*) as number_of_books_opened,
    count(distinct book_title) as number_of_distinct_books_opened,
    book_branding,
    country
from bloomreader.v_book_or_shelf_opened
where features like '%signLanguage%'
group by anonymous_id,
    book_branding,
    country;


