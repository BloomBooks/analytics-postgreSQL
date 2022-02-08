-- Trigger: insert_country_row

-- DROP TRIGGER IF EXISTS insert_country_row ON bloomapp.change_content_languages;

CREATE TRIGGER insert_country_row
    BEFORE INSERT
    ON bloomapp.change_content_languages
    FOR EACH ROW
    EXECUTE FUNCTION public.insert_ip_country_bloom_fctn();