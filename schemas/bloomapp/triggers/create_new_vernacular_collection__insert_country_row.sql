-- Trigger: insert_country_row

-- DROP TRIGGER IF EXISTS insert_country_row ON bloomapp.create_new_vernacular_collection;

CREATE TRIGGER insert_country_row
    BEFORE INSERT
    ON bloomapp.create_new_vernacular_collection
    FOR EACH ROW
    EXECUTE FUNCTION public.insert_ip_country_bloom_fctn();