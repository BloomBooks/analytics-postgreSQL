-- Trigger: insert_country_row

-- DROP TRIGGER IF EXISTS insert_country_row ON bloomapp.users;

CREATE TRIGGER insert_country_row
    BEFORE INSERT
    ON bloomapp.users
    FOR EACH ROW
    EXECUTE FUNCTION public.insert_context_ip_country_bloom_fctn();