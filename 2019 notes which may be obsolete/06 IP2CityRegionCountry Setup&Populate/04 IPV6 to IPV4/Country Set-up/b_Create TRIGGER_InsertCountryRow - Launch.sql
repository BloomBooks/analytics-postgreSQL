-- Trigger: insert_country_row 

-- DROP TRIGGER insert_country_row ON bloomapp.launch;

CREATE TRIGGER insert_country_row 
    BEFORE INSERT
    ON bloomapp.launch
    FOR EACH ROW
    EXECUTE PROCEDURE public.insert_ip_country_bloom_fctn();