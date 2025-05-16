-- PROCEDURE: common.refresh_materialized_views

-- DROP PROCEDURE common.refresh_materialized_views;

CREATE OR REPLACE PROCEDURE common.refresh_materialized_views()
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        CALL common.refresh_mv_in_transaction('common.mv_book_detail');
    END;
    BEGIN
        CALL common.refresh_mv_in_transaction('common.mv_download_book');
    END;
    BEGIN
        CALL common.refresh_mv_in_transaction('common.mv_pages_read');
    END;
    BEGIN
        CALL common.refresh_mv_in_transaction('common.mv_comprehension');
    END;
    BEGIN
        CALL common.refresh_mv_in_transaction('common.mv_reading_perbook_events');
    END;
    BEGIN
        CALL common.refresh_mv_in_transaction('common.mv_reading_perday_events');
    END;
    BEGIN
        CALL common.refresh_mv_in_transaction('common.mv_reading_perday_events_by_branding_and_country');
    END;
END; $$;

-- Helper procedure that executes each refresh in its own transaction.
CREATE OR REPLACE PROCEDURE common.refresh_mv_in_transaction(view_name TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    EXECUTE format('REFRESH MATERIALIZED VIEW %s', view_name);
    COMMIT;
END; $$;