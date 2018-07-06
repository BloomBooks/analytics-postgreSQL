-- Columns: bloomreadertest.clone_book_search.   VARIOUS

/*
ALTER TABLE bloomreadertest.clone_book_search DROP COLUMN browser;
ALTER TABLE bloomreadertest.clone_book_search DROP COLUMN browser_version;
ALTER TABLE bloomreadertest.clone_book_search DROP COLUMN osversion;
ALTER TABLE bloomreadertest.clone_book_search DROP COLUMN screen_height;
ALTER TABLE bloomreadertest.clone_book_search DROP COLUMN screen_width;
ALTER TABLE bloomreadertest.clone_book_search DROP COLUMN device;
ALTER TABLE bloomreadertest.clone_book_search DROP COLUMN search_keyword;
ALTER TABLE bloomreadertest.clone_book_search DROP COLUMN utm_content;
*/

ALTER TABLE bloomlibrary_org.preview
    ADD COLUMN context_campaign_source text COLLATE pg_catalog."default" NULL,
    ADD COLUMN context_campaign_term text COLLATE pg_catalog."default" NULL,
    ADD COLUMN context_campaign_name text COLLATE pg_catalog."default" NULL,
    ADD COLUMN context_campaign_medium text COLLATE pg_catalog."default" NULL,
	ADD COLUMN context_page_referrer_domain text COLLATE pg_catalog."default" NULL,
	ADD COLUMN search_engine text COLLATE pg_catalog."default" NULL,
	ADD COLUMN search_keyword text COLLATE pg_catalog."default" NULL,
	ADD COLUMN browser text COLLATE pg_catalog."default" NULL,
	ADD COLUMN browser_version text COLLATE pg_catalog."default" NULL,
	ADD COLUMN osversion text COLLATE pg_catalog."default" NULL,
	ADD COLUMN device text COLLATE pg_catalog."default" NULL,
	ADD COLUMN screen_height bigint NULL,
	ADD COLUMN screen_width bigint NULL,
    ADD COLUMN location_uid bigint;		
	-- ADD COLUMN utm_content text COLLATE pg_catalog."default" NULL;
	--
/*
ALTER TABLE bloomlibrary_org.book_search DROP COLUMN browser;
ALTER TABLE bloomlibrary_org.book_search DROP COLUMN browser_version;
ALTER TABLE bloomlibrary_org.book_search DROP COLUMN osversion;
ALTER TABLE bloomlibrary_org.book_search DROP COLUMN context_page_referrer_domain;
ALTER TABLE bloomlibrary_org.book_search DROP COLUMN screen_height;
ALTER TABLE bloomlibrary_org.book_search DROP COLUMN screen_width;
ALTER TABLE bloomlibrary_org.book_search DROP COLUMN device;
ALTER TABLE bloomlibrary_org.book_search DROP COLUMN search_engine;
ALTER TABLE bloomlibrary_org.book_search DROP COLUMN search_keyword;
ALTER TABLE bloomlibrary_org.book_search DROP COLUMN location_uid;
*/

ALTER TABLE bloomlibrary_org.book_search
	ADD COLUMN context_page_referrer_domain text COLLATE pg_catalog."default" NULL,
	ADD COLUMN osversion text COLLATE pg_catalog."default" NULL,
	ADD COLUMN browser text COLLATE pg_catalog."default" NULL,
	ADD COLUMN browser_version text COLLATE pg_catalog."default" NULL,
	ADD COLUMN screen_height bigint NULL,
	ADD COLUMN screen_width bigint NULL,
	ADD COLUMN device text COLLATE pg_catalog."default" NULL,
	ADD COLUMN search_engine text COLLATE pg_catalog."default" NULL,
	ADD COLUMN search_keyword text COLLATE pg_catalog."default" NULL,	
	ADD COLUMN location_uid bigint;
	--	