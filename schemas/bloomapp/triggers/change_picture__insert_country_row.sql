-- Trigger: insert_country_row

-- DROP TRIGGER IF EXISTS insert_country_row ON bloomapp.change_picture;

CREATE TRIGGER insert_country_row
    BEFORE INSERT
    ON bloomapp.change_picture
    FOR EACH ROW
    EXECUTE FUNCTION public.insert_ip_country_bloom_fctn();