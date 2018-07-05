-- Trigger: insert_location_uid 

-- DROP TRIGGER insert_location_uid ON bloomapp.launch;

CREATE TRIGGER insert_location_uid 
    BEFORE INSERT
    ON bloomapp.launch
    FOR EACH ROW
    EXECUTE PROCEDURE public.find_location_uid_4_launch_fctn();
	
-- Trigger: insert_location_uid 

-- DROP TRIGGER insert_location_uid ON bloomapp.created;

CREATE TRIGGER insert_location_uid 
    BEFORE INSERT
    ON bloomapp.created
    FOR EACH ROW
    EXECUTE PROCEDURE public.find_location_uid_4_created_fctn();	
	
-- Trigger: insert_location_uid 

-- DROP TRIGGER insert_location_uid ON bloomapp.create_book;

CREATE TRIGGER insert_location_uid 
    BEFORE INSERT
    ON bloomapp.create_book
    FOR EACH ROW
    EXECUTE PROCEDURE public.find_location_uid_4_create_book_fctn();	
	
-- Trigger: insert_location_uid 

-- DROP TRIGGER insert_location_uid ON bloomapp.create_book;

CREATE TRIGGER insert_location_uid 
    BEFORE INSERT
    ON bloomreader.application_installed
    FOR EACH ROW
    EXECUTE PROCEDURE public.find_location_uid_4_app_installed_fctn();