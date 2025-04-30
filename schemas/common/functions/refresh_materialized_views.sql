-- FUNCTION: common.refresh_materialized_views()

-- DROP FUNCTION common.refresh_materialized_views();

CREATE OR REPLACE FUNCTION common.refresh_materialized_views()
RETURNS void
AS $$
BEGIN
    PERFORM common.refresh_mv_in_transaction('common.mv_book_detail');
    PERFORM common.refresh_mv_in_transaction('common.mv_download_book');
    -- Some of the later views in this list use mv_pages_read, 
    -- so it needs to get refreshed before them.
    PERFORM common.refresh_mv_in_transaction('common.mv_pages_read');
    PERFORM common.refresh_mv_in_transaction('common.mv_comprehension');
    PERFORM common.refresh_mv_in_transaction('common.mv_reading_perbook_events');
    PERFORM common.refresh_mv_in_transaction('common.mv_reading_perday_events');
    PERFORM common.refresh_mv_in_transaction('common.mv_reading_perday_events_by_branding_and_country');
END; $$
LANGUAGE 'plpgsql';

-- Helper function that executes each refresh in its own transaction.
-- This means less total blocking time. And we hope it resolves deadlocks we were getting.    
CREATE OR REPLACE FUNCTION common.refresh_mv_in_transaction(view_name text)
RETURNS void
AS $$
BEGIN
    EXECUTE format('REFRESH MATERIALIZED VIEW %s', view_name);
END; $$
LANGUAGE 'plpgsql'
-- This is the key setting that makes each call run in a new transaction
SECURITY DEFINER;