---------------
--- segment ---
---------------
GRANT SELECT ON TABLE public.geography_city_centers to segment;

---------------
-- readbloom --
---------------
GRANT CONNECT ON DATABASE bloomsegment to readbloom;

GRANT USAGE ON SCHEMA bloomreader TO readbloom;
GRANT USAGE ON SCHEMA bloomreaderbeta TO readbloom;
GRANT USAGE ON SCHEMA public TO readbloom;

GRANT SELECT ON ALL TABLES IN SCHEMA bloomreader to readbloom;
GRANT SELECT ON ALL TABLES IN SCHEMA bloomreaderbeta to readbloom;
GRANT SELECT ON ALL TABLES IN SCHEMA public to readbloom;

-- give read permissions to future tables and views to readbloom (don't know if this covers existing ones)
ALTER DEFAULT PRIVILEGES IN SCHEMA bloomreader
GRANT SELECT ON TABLES TO readbloom;
ALTER DEFAULT PRIVILEGES IN SCHEMA bloomreaderbeta
GRANT SELECT ON TABLES TO readbloom;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO readbloom;

---------------
---- stats ----
---------------
GRANT CONNECT ON DATABASE bloomsegment to stats;
GRANT USAGE ON SCHEMA public TO stats;
GRANT SELECT ON TABLE common.mv_reading_perbook_events TO stats;
GRANT SELECT ON TABLE common.mv_reading_perday_events TO stats;
GRANT SELECT ON TABLE common.mv_reading_perday_events_by_branding_and_country TO stats;
GRANT SELECT ON TABLE common.mv_comprehension TO stats;
GRANT SELECT ON TABLE common.mv_pages_read TO stats;
GRANT SELECT ON TABLE common.mv_book_detail TO stats;
GRANT SELECT ON TABLE common.mv_download_book TO stats;
GRANT SELECT ON TABLE bloomlibrary_org.v_download_book to stats;
GRANT SELECT ON TABLE bloomlibrary_org.v_book_detail to stats;
GRANT SELECT ON TABLE bloomlibrary_org.v_pages_read to stats;
GRANT USAGE ON SCHEMA bloomreader TO stats;
GRANT SELECT ON TABLE bloomreader.v_book_or_shelf_opened to stats;
GRANT SELECT ON TABLE bloomreader.v_pages_read to stats;
GRANT SELECT ON TABLE bloomreader.v_comprehension to stats;