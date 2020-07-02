-- View: bloomlibrary_org.v_book_detail

-- DROP VIEW bloomlibrary_test.v_book_detail;

CREATE OR REPLACE VIEW bloomlibrary_test.v_book_detail AS
    SELECT  book as book_id,
            book_instance_id,
            timestamp
    FROM    bloomlibrary_test.book_detail
;


ALTER TABLE bloomlibrary_org.v_book_detail
    OWNER TO silpgadmin;