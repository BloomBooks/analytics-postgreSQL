-- View: bloomlibrary_org.v_book_detail

-- DROP VIEW bloomlibrary_org.v_book_detail;

CREATE OR REPLACE VIEW bloomlibrary_org.v_book_detail AS
    SELECT  book as book_id,
            book_instance_id,
            timestamp
    FROM    bloomlibrary_org.book_detail
;


ALTER TABLE bloomlibrary_org.v_book_detail
    OWNER TO silpgadmin;