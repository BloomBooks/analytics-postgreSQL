-- Trigger: insert_country_row

-- DROP TRIGGER insert_country_row ON bloomreaderbeta.book_or_shelf_opened;

CREATE TRIGGER insert_country_row
    BEFORE INSERT
    ON bloomreaderbeta.book_or_shelf_opened
    FOR EACH ROW
    EXECUTE PROCEDURE public.insert_context_ip_country_bloom_fctn();