-- DROP FUNCTION public.get_publisher_stats(VARCHAR);

CREATE OR REPLACE FUNCTION public.get_publisher_stats(
	p_publisher VARCHAR)
    RETURNS TABLE (publisher TEXT, totalReads INT, totalDownloads INT)
AS $$

DECLARE

BEGIN
    RETURN QUERY
    SELECT  cast (p_publisher as text),
            0 as totalReads,
            (SELECT cast (count(*) as int)
            FROM    bloomlibrary_org.v_download_book bl
            WHERE   (bl.publisher = p_publisher OR bl.originalPublisher = p_publisher)
            ) AS totalDownloads
    ;
END; $$

LANGUAGE 'plpgsql';