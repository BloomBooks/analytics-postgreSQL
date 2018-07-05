-- Trigger: find_country

-- DROP TRIGGER find_country ON bloomreaderbeta.pages_read;

CREATE TRIGGER find_country
    BEFORE INSERT
    ON bloomreaderbeta.pages_read
    FOR EACH ROW
    EXECUTE PROCEDURE public.find_country_fctn();
	
	