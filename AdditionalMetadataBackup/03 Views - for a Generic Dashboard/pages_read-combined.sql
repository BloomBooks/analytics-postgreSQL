-- Bloom 1.x (through 1.3, at least) separated analytics out into different tables.
-- That makes it hard to count the beta, which is substantial (currently 1/3 of use).
-- at this point we don't have an "alpha" version, and probably should keep that out of any reporting.
-- This table just puts them together and adds a column for channel (which is also already part of the version column)

CREATE OR REPLACE VIEW bloomreader.pages_read_combined AS
SELECT *,
    'release' channel
    FROM bloomreader.pages_read
UNION
SELECT *, 
    'beta' channel
    FROM bloomreaderbeta.pages_read