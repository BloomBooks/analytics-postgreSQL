-- View: bloomreader.v_number_of_books_opened

-- DROP VIEW bloomreader.v_number_of_books_opened;

CREATE OR REPLACE VIEW bloomreader.v_number_of_books_opened AS

select context_device_id, 
    count(distinct title) as number_of_books_opened
from bloomreader.book_or_shelf_opened
group by context_device_id;


