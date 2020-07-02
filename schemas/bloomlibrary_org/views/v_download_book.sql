-- View: bloomlibrary_org.v_download_book

-- DROP VIEW bloomlibrary_test.v_download_book;

CREATE OR REPLACE VIEW bloomlibrary_test.v_download_book AS
    SELECT  book as book_id,
            book_instance_id,
            event_type,
            timestamp,
            book_title
    FROM    bloomlibrary_test.download_book
;


ALTER TABLE bloomlibrary_org.v_download_book
    OWNER TO silpgadmin;