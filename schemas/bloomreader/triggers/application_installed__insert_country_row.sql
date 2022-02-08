-- Trigger: insert_country_row

-- DROP TRIGGER IF EXISTS insert_country_row ON bloomreader.application_installed;

CREATE TRIGGER insert_country_row
    BEFORE INSERT
    ON bloomreader.application_installed
    FOR EACH ROW
    EXECUTE FUNCTION public.insert_context_ip_country_bloom_fctn();