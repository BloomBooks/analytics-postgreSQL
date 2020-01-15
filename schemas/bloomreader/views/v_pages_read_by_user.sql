-- View: bloomreader.v_pages_read_by_user

-- DROP VIEW bloomreader.v_pages_read_by_user;

CREATE OR REPLACE VIEW bloomreader.v_pages_read_by_user AS

select 
    anonymous_id, 
    sum(pages_read),
    book_branding, 
    country
from 
    bloomreader.v_pages_read
group by 
    anonymous_id, 
    book_branding, 
    country