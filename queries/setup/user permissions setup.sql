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

