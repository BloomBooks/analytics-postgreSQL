-- Trigger: insert_country_row 

-- DROP TRIGGER insert_country_row ON bloomreadertest.application_installed;

CREATE TRIGGER insert_country_row 
    BEFORE INSERT
    ON bloomreadertest.application_installed
    FOR EACH ROW
    EXECUTE PROCEDURE public.insert_ip_country_row_fctn();