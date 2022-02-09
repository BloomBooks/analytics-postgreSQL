-- Trigger: insert_country_row

-- DROP TRIGGER IF EXISTS insert_country_row ON bloomlibrary_org.download_book;

CREATE TRIGGER insert_country_row
    BEFORE INSERT
    ON bloomlibrary_org.download_book
    FOR EACH ROW
    EXECUTE FUNCTION public.insert_context_ip_country_bloom_fctn();