-- View: bloomapp.v_create_book_count_by_month

-- DROP VIEW bloomapp.v_create_book_count_by_month;

CREATE OR REPLACE VIEW bloomapp.v_book_stats
SELECT  cast (p_bookId as text),
        0 as totalReads,
        (SELECT count(*)
        FROM    bloomlibrary_org.download_book bl
        WHERE   bl.book = p_bookId) AS totalDownloads
;