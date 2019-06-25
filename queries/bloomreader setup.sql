GRANT CONNECT ON DATABASE bloomsegment to readbloom;

GRANT USAGE ON SCHEMA bloomreader TO readbloom;

GRANT
SELECT ON ALL TABLES IN SCHEMA bloomreader to readbloom;

-- give read permissions to future tables and views to readbloom (don't know if this covers existing ones)

ALTER DEFAULT PRIVILEGES IN SCHEMA bloomreader GRANT
SELECT ON TABLES TO readbloom;

