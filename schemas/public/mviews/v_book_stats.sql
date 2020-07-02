-- Materialized View: public.mv_book_stats

-- DROP MATERIALIZED VIEW public.mv_book_stats;

CREATE MATERIALIZED VIEW public.mv_book_stats AS

WITH    downloads AS 
        (SELECT d.book_id,
                d.event_type, 
                count(*) AS cnt
        FROM    bloomlibrary_test.v_download_book d
        GROUP BY d.book_id, d.event_type
        -- order by 1,2,3
        -- limit 100
        ),
        bloomReaderOpens AS
        (SELECT o.book_instance_id,
                count(*) AS cnt,
                count(distinct o.device_unique_id) deviceCount
        FROM    bloomreader.v_book_or_shelf_opened o
        GROUP BY o.book_instance_id
        )
SELECT  downloads.book_id,
        bloomReaderOpens.book_instance_id,
        COALESCE((SELECT SUM(cnt) FROM downloads dd WHERE dd.book_id = downloads.book_id AND event_type <> 'read'), 0) as total_downloads,
        COALESCE((SELECT SUM(cnt) FROM downloads dd WHERE dd.book_id = downloads.book_id AND event_type = 'read'), 0) as total_reads,
        COALESCE((SELECT cnt FROM bloomReaderOpens oo WHERE oo.book_instance_id = bloomReaderOpens.book_instance_id), 0) AS bloomReaderReads
-- FROM    downloads
-- GROUP BY downloads.book_id
-- order by 1--,2
limit 100
;