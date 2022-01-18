-- Trigger: insert_country_row 

-- DROP TRIGGER insert_country_row ON bloomreadertest.application_opened;

CREATE TRIGGER insert_country_row 
    BEFORE INSERT
    ON bloomreadertest.application_opened
    FOR EACH ROW
    EXECUTE PROCEDURE public.insert_ip_country_row_fctn();