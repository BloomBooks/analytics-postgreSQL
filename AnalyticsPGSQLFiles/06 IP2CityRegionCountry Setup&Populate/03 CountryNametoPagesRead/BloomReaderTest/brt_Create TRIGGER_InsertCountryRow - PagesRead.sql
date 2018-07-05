-- Trigger: insert_country_row 

-- DROP TRIGGER insert_country_row ON bloomreadertest.pages_read;

CREATE TRIGGER insert_country_row 
    BEFORE INSERT
    ON bloomreadertest.pages_read
    FOR EACH ROW
    EXECUTE PROCEDURE public.insert_ip_country_row_fctn();