-- Trigger: find_country

-- DROP TRIGGER find_country ON bloomreader.pages_read;

CREATE TRIGGER find_country
    BEFORE INSERT
    ON bloomreader.pages_read
    FOR EACH ROW
    EXECUTE PROCEDURE public.find_country_fctn();
	
	