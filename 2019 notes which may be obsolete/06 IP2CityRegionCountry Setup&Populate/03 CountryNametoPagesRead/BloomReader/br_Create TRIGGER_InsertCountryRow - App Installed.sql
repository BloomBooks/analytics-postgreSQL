-- Trigger: insert_country_row 

-- DROP TRIGGER insert_country_row ON bloomreader.pages_read;

CREATE TRIGGER insert_country_row 
    BEFORE INSERT
    ON bloomreader.application_installed
    FOR EACH ROW
    EXECUTE PROCEDURE public.insert_ip_country_row_fctn();
	
