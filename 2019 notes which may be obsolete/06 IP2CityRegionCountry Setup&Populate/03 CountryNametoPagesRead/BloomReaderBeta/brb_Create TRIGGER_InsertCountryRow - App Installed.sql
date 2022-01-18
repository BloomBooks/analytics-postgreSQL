-- Trigger: insert_country_row 

-- DROP TRIGGER insert_country_row ON bloomreaderbeta.application_installed;

CREATE TRIGGER insert_country_row 
    BEFORE INSERT
    ON bloomreaderbeta.application_installed
    FOR EACH ROW
    EXECUTE PROCEDURE public.insert_ip_country_row_fctn();